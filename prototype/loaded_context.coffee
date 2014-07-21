transition_factory = require('./nlp/transition_factory').TransitionFactory

temporal_dialogue= {
}

context_decorators = {
    dialogue: {}
    observation: {}
    movement: {}
    action: {}
    silence : {}
}

context_transitions = {
    dialogue: {}
    observation: {}
    movement: {}
    action: {}
    silence : undefined
}

prepareTransition = (type, character = undefined)->
    switch type
        when 'dialogue'
            phrases = Object.keys(context_decorators.dialogue[character])
            if phrases?.length > 0
                context_transitions.dialogue[character] = transition_factory.build(phrases)
        when 'silence'
            context_transitions.silence = transition_factory.build([''])
        else
            phrases = Object.keys(context_decorators[type])
            if phrases?.length > 0
                context_transitions[type] = transition_factory.build(phrases)

containsQuestionOnLastLine = (text)->
    lines = text.trim().split('\n')
    last_line = lines[lines.length-1]
    return last_line.indexOf('?') > 0 
                
module.exports.loadNode = (node)->
    isAnswerExpected = containsQuestionOnLastLine(node.text)
    stateAggregate = {}
    for character in Object.keys(context_decorators.dialogue)
        stateAggregate[character] = Object.keys(context_decorators.dialogue[character]).join('')
    
    for character in Object.keys(temporal_dialogue)
        for input in temporal_dialogue[character]
            delete context_decorators.dialogue[character][input]
        delete temporal_dialogue[character]
    
    for character in Object.keys(node.dialogue)
        context_decorators.dialogue[character] = context_decorators.dialogue[character] || {}
        for input,decorator of node.dialogue[character]
            context_decorators.dialogue[character][input] = decorator
            if isAnswerExpected
                temporal_dialogue[character] = temporal_dialogue[character] || []
                temporal_dialogue[character].push(input)
    
    for character in Object.keys(context_decorators.dialogue)
        newState = Object.keys(context_decorators.dialogue[character]).join('')
        if(newState != stateAggregate[character])
            prepareTransition('dialogue',character)
                
                
    movementAdded = false
    for input,decorator of node.movement
        movementAdded = true
        context_decorators.movement[input] = decorator

    observationAdded = false
    for input,decorator of node.observation
        observationAdded = true
        context_decorators.observation[input] = decorator

    actionAdded = false
    for input,decorator of node.action
        actionAdded = true
        context_decorators.action[input] = decorator
        
    if (node.silence)
       context_decorators.silence = { "" : node.silence } 
       prepareTransition('silence')

    if movementAdded
        prepareTransition('movement')
    if observationAdded
        prepareTransition('observation')
    if actionAdded
        prepareTransition('action')

module.exports.getTransition = (lookup...) ->
    result = context_transitions[lookup[0]]
    for path in lookup[1..]
        if result[path]
            result = result[path]
        else break
            
    return result 
    
module.exports.getDecorator = (match,lookup...)->
    result = context_decorators[lookup[0]]
    for path in lookup[1..]
        if result[path]
            result = result[path]
        else break
    return result?[match] 
    