q = require 'Q'
entities = require('./entities').getAllKnownEntities()

isQuestion = /\?|what|where|why|how|ask/
isExclamation = /(hi|hello|howdy|greetings|!)( .*|$)/

entitiesRegexString = "(#{entities.join('|')})$".toLowerCase()
containsEntity = new RegExp(entitiesRegexString);

isCardinalDirection = /(north|south|east|west|left|right|up|down)$/
isMovementVerb = /^(go|walk|move|jump|sprint|step)/

isObservationVerb = /^(inspect|examine|check|analyse|observe)/
classifyByVerb = (input) ->
        if(isObservationVerb.test(input))
            return "observation"
        return 'movement'
            
module.exports.interpretAsync = (input)->
    deferred = q.defer()
    input = input.toLowerCase()

    setImmediate(->
        type = 'observation'
       
        if(isCardinalDirection.test(input) && isMovementVerb.test(input))
            type = 'movement'
        
        if(containsEntity.test(input))
            type = classifyByVerb(input)
        
        if (isQuestion.test(input) || isExclamation.test(input))
            type = 'dialog'
            
        deferred.resolve({
            type: type
        });
    )
    return deferred.promise;
    
   