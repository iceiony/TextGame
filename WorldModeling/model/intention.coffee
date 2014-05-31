q = require 'Q'
entities = require('./entities').getAllKnownEntities()
characters = require('./entities').getAllKnownCharacters()

isQuestion = /\?|what|where|why|how|ask|can you/
isExclamation = /(hi|hello|howdy|greetings|!)( .*|$)/

entitiesRegexString = "(#{entities.join('|')})".toLowerCase()
containsEntity = new RegExp(entitiesRegexString);

charactersRegexString = "(#{characters.join('|')})".toLowerCase()
containsCharacter = new RegExp(charactersRegexString);

isDirection = /(north|south|east|west|left|right|up|down|around)$/
isMovementVerb = /^(go|walk|move|jump|sprint|step|run)/

isObservationVerb = /^(inspect|examine|check|analyse|observe|look)/


module.exports.interpretAsync = (input)->
    deferred = q.defer()
    input = input.toLowerCase()

    setImmediate(->
        target = undefined
        type = 'action'

        if isMovementVerb.test(input) && ( isDirection.test(input) || containsEntity.test(input) )
            type = 'movement'

        if isObservationVerb.test(input) && ( containsEntity.test(input) || isDirection.test(input) )
            type = 'observation'

        if isQuestion.test(input) || isExclamation.test(input)
            type = 'dialog'
            target = 'implicit'
            match = containsCharacter.exec(input)
            if match then target = match[0]
            

        deferred.resolve({
            type: type
            input: input
            target : target
        });
    )
    return deferred.promise;
    
   