Transition = require './transition'
transitionObjectCache = {};

getTransitionFromCache = (allTransitionStrings)->
    cacheKey = allTransitionStrings.join('')
    return transitionObjectCache[cacheKey]

putTransitionInCache = (allTransitionStrings, transition) ->
    cacheKey = allTransitionStrings.join('')
    transitionObjectCache[cacheKey] = transition


class TransitionFactory
    sayTransition: (transitionStrings) ->
        transitionInCache = getTransitionFromCache(transitionStrings)
        if transitionInCache != undefined
            return transitionInCache
        else
            transition = new Transition(transitionStrings)
            putTransitionInCache(transitionStrings, transition)

module.exports.TransitionFactory = new TransitionFactory() 