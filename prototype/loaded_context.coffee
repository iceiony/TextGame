transition_factory = require('./nlp/transition_factory').TransitionFactory

context = {
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
            phrases = Object.keys(context.dialogue[character])
            if phrases?.length > 0
                context_transitions.dialogue[character] = transition_factory.build(phrases)
        else
            phrases = Object.keys(context[type])
            if phrases?.length > 0
                context_transitions[type] = transition_factory.build(phrases)

module.exports.loadNode = (node)->
    for character in Object.keys(node.dialogue)
        context.dialogue[character] = context.dialogue[character] || {}
        for input,decorator of node.dialogue[character]
            context.dialogue[character][input] = decorator
        prepareTransition("dialogue", character)

    movementAdded = false
    for input,decorator of node.movement
        movementAdded = true
        context.movement[input] = decorator

    observationAdded = false
    for input,decorator of node.observation
        observationAdded = true
        context.action[input] = decorator

    actionAdded = false
    for input,decorator of node.action
        actionAdded = true
        context.action[input] = decorator

    if movementAdded
        prepareTransition('movement')
    if observationAdded
        prepareTransition('observation')
    if actionAdded
        prepareTransition('action')

module.exports.transitions = context_transitions
module.exports.decorators = context
    