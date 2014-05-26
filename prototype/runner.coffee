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
startTime = new Date()

prepareTransitions = ->
    setImmediate(->
        allCharacterDialogue = context.getAllCharacterDialogue()
        for characterName , dialogue of allCharacterDialogue
            keys = Object.keys(dialogue)
            dialogueTransitions[characterName] = TransitionFactory.sayTransition(keys)
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
    dialogueTransitions[character].matchAsync(userInput)
    .done((result)->
        allDialogue = context.getAllCharacterDialogue()
        dialogueDecorator = allDialogue[character][result.match]

        if result.match && dialogueDecorator && not dialogueDecorator.wasUsed 
            decoratorDefer.resolve(dialogueDecorator)
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