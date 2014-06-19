Transition = require './transition'
transitionObjectCache = {};

getTransitionFromCache = (allTransitionStrings)->
    cacheKey = allTransitionStrings.join('')
    return transitionObjectCache[cacheKey]

putTransitionInCache = (allTransitionStrings, transition) ->
    cacheKey = allTransitionStrings.join('')
    transitionObjectCache[cacheKey] = transition


class TransitionFactory
    
    build: (allTransitionStrings) ->
        transitionInCache = getTransitionFromCache(allTransitionStrings)
        if transitionInCache != undefined
            return transitionInCache
        else
            transition = new Transition(allTransitionStrings)
            putTransitionInCache(allTransitionStrings, transition)
            
module.exports.TransitionFactory = new TransitionFactory() 