q = require 'Q'
util = require './util'
{intention,environment,aggregator} = require('world-modeling')

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
            intent = reaction.intention
            if intent.type == 'dialogue'
                transition = context_transitions.dialogue[intent.entity]
            else 
                transition = context_transitions[intent.type]
            promises.push(transition?.matchAsync(intent.input))
            promises = promises.filter((promise)-> promise)
        return q.all(promises)
    )
    .done((context_reaction)->
        for index in [0..context_reaction.length - 1 ]
            decorator = util.toDecorator(aggregator.aggregate(environment_reaction[index]))
            match = context_reaction[index].match
            if match
                intent = environment_reaction[index].intention
                if intent.type == 'dialogue'
                    decorator = loaded_context.decorators.dialogue[intent.entity][match]
                else
                    decorator = loaded_context.decorators[intent.type][match]
            else
            decorator.call(node_builder)
        
        node = node_builder.extractNode()
        loaded_context.loadNode(node)
        current_text = node.text

        deferred.resolve()
    )

    return deferred.promise;