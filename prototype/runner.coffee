q = require 'Q'
Context = require './context'
Transition = require './nlp/transition'
server_logging = require './server_logging/logging_client'
story = require './story/story'


decorator = story.intro
context = new Context()
startTime = new Date()


decorator.call(context);
transition = new Transition(context.getCurrentTransitions())
current_text = context.toString() + "-> "


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
    transition = new Transition(context.getCurrentTransitions())

    current_text = "[#{result.match}]\n" +
      context.toString() + "->"

    deferred.resolve())

  return deferred.promise;