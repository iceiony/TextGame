q = require 'Q'
util = require './util'
{intention,environment,aggregator} = require('world-modeling')
events = require('events')

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

    intention.interpretAsync(userInput,current_text)
    .then((interpretation)->
        environment.reactAsync(interpretation)
    )
    .done((reactions,err)->
        eventEmitter = new events.EventEmitter()
        current_text = ""

        processNextReaction = (reaction)->
            intent = reaction.intention
            entityCanonicalName  = environment.getObjectByName(intent.entity)?.name

            transition = loaded_context.getTransition(intent.type, entityCanonicalName)
            if transition.matchAsync != undefined 
                transition.matchAsync(intent.input).done((result,err)->
                    decorator = loaded_context.getDecorator(result.match, intent.type, entityCanonicalName)
                    eventEmitter.emit('transition decorator', decorator,reaction)
                )
            else
                eventEmitter.emit('transition decorator', undefined, reaction)

        eventEmitter.on('transition decorator', (decorator,reaction) ->
            if not decorator
                text = aggregator.aggregate(reaction)
                decorator = util.toDecorator(text)

            decorator.call(node_builder)
            node = node_builder.extractNode()
            loaded_context.loadNode(node)
            current_text += node.text + "\n"

            if reactions.length > 0
                processNextReaction(reactions.shift())
            else
                deferred.resolve()
        )

        processNextReaction(reactions.shift())
    )
    

    return deferred.promise;