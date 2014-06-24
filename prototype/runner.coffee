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
        for reaction in reactions 
            intent = reaction.intention
            transition = loaded_context.getTransition(intent.type,intent.entity)
            promises.push(transition?.matchAsync(intent.input))
        promises = promises.filter((promise)-> promise)
        
        return q.all(promises)
    )
    .done((context_reaction)->
        environment_reaction.map((element, index)->
            if(context_reaction[index]?.match)
                match = context_reaction[index]?.match
                intent = environment_reaction[index].intention
                return loaded_context.getDecorator(intent.type, intent.entity)[match]
            else
                reaction = environment_reaction[index]
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