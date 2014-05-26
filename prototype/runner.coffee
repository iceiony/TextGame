q = require 'Q'
Context = require './context'
util = require './util'
TransitionFactory = require('./nlp/transition_factory').TransitionFactory
server_logging = require './server_logging/logging_client'
story = require './story/story'
colouriseDialog = require('./story/characters').colouriseDialog
characterModels = require('./story/characters').characters

##initialize for first read
introDecorator = story.intro
context = new Context()
dialogueTransitions = {}
allKnownActions = {}
actionTransition = undefined
startTime = new Date()

extractEntityFrom = (actionString)->
    if (actionString == 'look around')
        return 'environment'

mergeIntoKnownActions = (newActions)->
    for object,actions of newActions
        allKnownActions[object] = allKnownActions[object] || []
        for action in actions
            if(allKnownActions[object].indexOf(action) < 0 )
                allKnownActions[object].push(action)

prepareTransitions = ->
    setImmediate(->
        allCharacterDialogue = context.getAllCharacterDialogue()
        for characterName , dialogueOptions of allCharacterDialogue
            options = Object.keys(dialogueOptions)
            dialogueTransitions[characterName] = TransitionFactory.sayTransition(options)

        newActions = {}
        for action in Object.keys(context.getActions())
            object = extractEntityFrom(action)
            newActions[object] = newActions[object] || []
            newActions[object].push(action)
        mergeIntoKnownActions(newActions)

        nearbyEntities = [].concat.apply(['environment'], context.getCharactersNearby())
        nearbyEntities = [].concat.apply(nearbyEntities, context.getObjectsNearby())

        currentPossibleActions = []
        for object in nearbyEntities
            currentPossibleActions = [].concat.apply(currentPossibleActions, allKnownActions[object])
        actionTransition = TransitionFactory.actionTransition(currentPossibleActions)
    )

introDecorator.call(context);
prepareTransitions()


module.exports.getCurrentText = ()->
    current_text = colouriseDialog(context.getText()) + "-> "
    totalTimeInGame = (new Date() - startTime) / ( 1000 * 60 )
    server_logging.record("\n[#{totalTimeInGame}]\n#{current_text}")
    return current_text


module.exports.processAsync = (userInput) ->
    server_logging.record(userInput)
    processDefer = q.defer()

    decoratorDefer = q.defer()
    character = context.getCurrentFocus()
    q.all([
        dialogueTransitions[character].matchAsync(userInput)
        actionTransition.matchAsync(userInput)
    ])
    .done((results)->
        allDialogue = context.getAllCharacterDialogue()
        dialogueDecorator = allDialogue[character][results[0].match]
        if results[0].match && dialogueDecorator && not dialogueDecorator.wasUsed
            decoratorDefer.resolve(dialogueDecorator)
            return
        
        allActions = context.getActions()
        actionDecorator = allActions[results[1].match]
        if results[1].match && actionDecorator
            decoratorDefer.resolve(actionDecorator)
            return

        characterModels[character].tellAsync(userInput)
        .done((dialogue)->
            decorator = util.toDecorator(dialogue)
            decoratorDefer.resolve(decorator))
    )

    decoratorDefer.promise.done((decorator)->
        decorator.call(context)
        processDefer.resolve()

        prepareTransitions()
    )

    return processDefer.promise;