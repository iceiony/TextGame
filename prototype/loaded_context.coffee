transition_factory = require('./nlp/transition_factory').TransitionFactory

context_decorators = {
    dialogue: {}
    observation: {}
    movement: {}
    action: {}
}

context_transitions = {
    dialogue: {}
    observation: {}
    movement: {}
    action: {}
}

prepareTransition = (type, character = undefined)->
    switch type
        when 'dialogue'
            phrases = Object.keys(context_decorators.dialogue[character])
            if phrases?.length > 0
                context_transitions.dialogue[character] = transition_factory.build(phrases)
        else
            phrases = Object.keys(context_decorators[type])
            if phrases?.length > 0
                context_transitions[type] = transition_factory.build(phrases)

module.exports.loadNode = (node)->
    for character in Object.keys(node.dialogue)
        context_decorators.dialogue[character] = context_decorators.dialogue[character] || {}
        for input,decorator of node.dialogue[character]
            context_decorators.dialogue[character][input] = decorator
        prepareTransition("dialogue", character)

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
    