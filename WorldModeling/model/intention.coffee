q = require 'Q'
entities = require('./entities').getAllKnownEntities()

isQuestion = /\?|what|where|why|how|ask/
isExclamation = /(hi|hello|howdy|greetings|!)( .*|$)/

entitiesRegexString = "(#{entities.join('|')})$".toLowerCase()
containsEntity = new RegExp(entitiesRegexString);

isDirection = /(north|south|east|west|left|right|up|down|around)$/
isMovementVerb = /^(go|walk|move|jump|sprint|step|run)/

isObservationVerb = /^(inspect|examine|check|analyse|observe|look)/

            
module.exports.interpretAsync = (input)->
    deferred = q.defer()
    input = input.toLowerCase()

    setImmediate(->
        type = 'action'
       
        if isMovementVerb.test(input) && ( isDirection.test(input) || containsEntity.test(input) )
            type = 'movement'
        
        if isObservationVerb.test(input) && ( containsEntity.test(input) || isDirection.test(input) )
            type = 'observation'
        
        if isQuestion.test(input) || isExclamation.test(input)
            type = 'dialog'
            
        deferred.resolve({
            type: type
        });
    )
    return deferred.promise;
    
   