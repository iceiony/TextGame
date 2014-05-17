q = require 'Q'
Context = require './context'
Transition = require './nlp/transition'
server_logging = require './server_logging/logging_client'
story = require './story/story'


decorator = story.intro
context = new Context()
startTime = new Date()


decorator.call(context);
current_text = context.toString() + "-> "
transition = new Transition(context.getCurrentTransitions())



module.exports.getCurrentText = ()->
  return current_text;


module.exports.processAsync = (userInput) ->
  deferred = q.defer()

  transition.matchAsync(userInput)
  .then((result)->
    totalTimeInGame = (new Date() - startTime) / ( 1000 * 60 )
    server_logging.record("[#{result.match}] - #{totalTimeInGame} \n\n")

    currentLocation = context._curentLocation;

    decorator = context._locations[currentLocation]?[result.match] ||
      context._general[result.match] ||
      context._general["default"]

    decorator.call(context);
    
    matchHint = if (result.match.length <= 80) then result.match else  result.match.substr(0,77) + "..."
    current_text = "[#{matchHint}]\n\n #{context.toString()}->"
    deferred.resolve()
    
    deferred.promise.done(()->
      transition = new Transition(context.getCurrentTransitions())
      )
  )

  return deferred.promise;