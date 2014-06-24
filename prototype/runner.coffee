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

    model_reactions = undefined 
    intention.interpretAsync(userInput)
    .then((interpretation)->
        environment.reactAsync(interpretation)
    )
    .then((reactions)->
        model_reactions = reactions     
        
        transition_promises = []
        for reaction in reactions 
            intent = reaction.intention
            transition = loaded_context.getTransition(intent.type,intent.entity)
            transition_promises.push(transition?.matchAsync(intent.input))
        transition_promises = transition_promises.filter((promise)-> promise)
        
        return q.all(transition_promises)
    )
    .done((transitions)->
        model_reactions.map((element, index)->
            if(transitions[index]?.match)
                match = transitions[index]?.match
                intent = model_reactions[index].intention
                return loaded_context.getDecorator(intent.type, intent.entity)[match]
            else
                reaction = model_reactions[index]
                text = aggregator.aggregate(reaction)
                return util.toDecorator(text)
        )
        .forEach((decorator)->
            decorator.call(node_builder)
        )
        
        node = node_builder.extractNode()
        loaded_context.loadNode(node)
        current_text = node.text

        deferred.resolve()
    )

    return deferred.promise;