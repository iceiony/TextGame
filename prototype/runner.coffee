q = require 'Q'
util = require './util'
{intention,environment} = require('world-modeling')

server_logging = require './server_logging/logging_client'
colouriseDialog = require('./story/characters').colouriseDialog

##initialize for first read
node_builder = require('./node_builder').NodeBuilder
loaded_context = require './loaded_context'
story = require './story/story'

story.intro.call(node_builder)
introNode = node_builder.extractNode()
loaded_context.loadNode(introNode)

current_text = introNode.text
module.exports.getCurrentText = ()->
    server_logging.record(current_text)
    colouredText = colouriseDialog(current_text) + "-> "
    return colouredText

    
module.exports.processAsync = (userInput) ->
    userInput = userInput.trim()
    server_logging.record(userInput)
    deferred = q.defer()

    environment_reaction = undefined 
    intention.interpretAsync(userInput)
    .then((interpretation)->
        environment.reactAsync(interpretation)
    )
    .then((reactions)->
        environment_reaction = reactions     
        promises = []
        context_transitions = loaded_context.transitions
        for reaction in reactions 
            intention = reaction.intention
            if intention.type == 'dialogue'
                transition = context_transitions.dialogue[intention.entity]
            else 
                transition = context_transitions[intention.type]
            promises.push(transition?.matchAsync(intention.input))
        return q.all(promises)
    )
    .done((context_reaction)->
        deferred.resolve()
    )

    return deferred.promise;