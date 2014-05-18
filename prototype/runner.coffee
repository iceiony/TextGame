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


currentTransitionStrings = context.getCurrentTransitions()
transition = new Transition(currentTransitionStrings)
transitionCache = {}
transitionCache[currentTransitionStrings.join('')] = transition;

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

    matchHint = result.match || "no match";
    if (matchHint.length > 80)
      matchHint = matchHint.substr(0, 77) + "..."

    current_text = "[#{matchHint}]\n\n #{context.toString()}->"
    deferred.resolve()

    deferred.promise.done(()->
      currentTransitionStrings = context.getCurrentTransitions()
      cacheKey = currentTransitionStrings.join('');
      if ( transitionCache[cacheKey] == undefined )
        transition = new Transition(currentTransitionStrings)
        transitionCache[cacheKey] = transition
      else
        transition = transitionCache[cacheKey];
    )
  )

  return deferred.promise;