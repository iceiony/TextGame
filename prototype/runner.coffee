q = require 'Q'
Context = require './context'
Transition = require './nlp/transition'
server_logging = require './server_logging/logging_client'
story = require './story/story'
colouriseDialog = require('./story/characters').colouriseDialog

decorator = story.intro
context = new Context()
dialogueTransitions = {}
startTime = new Date()

prepareTransitions = ->
    setImmediate(->
        allCharacterDialogue = context.getAllCharacterDialogue()
        for characterName , dialogue of allCharacterDialogue
            keys = Object.keys(dialogue)
            dialogueTransitions[characterName] = new Transition(keys)
    )


decorator.call(context);
current_text = colouriseDialog(context.getText()) + "-> "
prepareTransitions()

module.exports.getCurrentText = ()->
    totalTimeInGame = (new Date() - startTime) / ( 1000 * 60 )
    server_logging.record("\n[#{totalTimeInGame}]\n#{current_text}")
    return current_text


module.exports.processAsync = (userInput) ->
    server_logging.record(userInput)
    deferred = q.defer()

    character = context.getCurrentFocus()
    dialogueTransitions[character].matchAsync(userInput)
    .done((result)->
        allDialogue = context.getAllCharacterDialogue()
        characterDialogue = allDialogue[character]
        decorator = characterDialogue[result.match]

        decorator.call(context);
        current_text = colouriseDialog(context.getText()) + "-> "

        current_text = colouriseDialog(context.getText())
        deferred.resolve()

        deferred.promise.done(->
            prepareTransitions()
        )
    )


    return deferred.promise;