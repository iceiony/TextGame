_ = require 'lodash'
q = require 'Q'
helper = require './pos_helper'


entities = require('./entities/environment').getAllEntityNames()
characters = require('./entities/environment').getAllCharacterNames()

isQuestion = /\?|what |where |why |how |ask |can you |tell /
isExclamation = /(hi|hello|howdy|greetings|!)( .*|$)/

entitiesRegexString = "(#{entities.join('|')})".toLowerCase()
containsEntity = new RegExp(entitiesRegexString)

charactersRegexString = "(#{characters.join('|')})".toLowerCase()
containsCharacter = new RegExp(charactersRegexString)

isDirection = /(north|south|east|west|left|right|up|down|around)/
isMovementVerb = /^(go|walk|move|jump|sprint|step|run)/
distanceAndMetric = /(\d+ ?[a-zA-Z]*|\d+ ?[a-zA-Z]*)( |$)/

isObservationVerb = /^(inspect|examine|check|analyse|observe|look)/


module.exports.interpretAsync = (input)-> 
    deferred = q.defer()
    input = input.toLowerCase()

    setImmediate(->
        direction = undefined 
        object = undefined
        distance = undefined
        subject = undefined 
        unit = undefined
        verb = undefined
        type = 'action'

        if isMovementVerb.test(input) && ( isDirection.test(input) || containsEntity.test(input) )
            type = 'movement'
            distance = 'implicit'
            if containsEntity.test(input)
                objectMatch = containsEntity.exec(input)
                object = objectMatch[0]
            
            if distanceAndMetric.test(input)
                distanceString = distanceAndMetric.exec(input)[0].trim()
                unit = /[a-zA-Z]+/.exec(distanceString)[0]
                distance = parseInt(/\d+/.exec(distanceString)[0])
            

        if isObservationVerb.test(input) && ( containsEntity.test(input) || isDirection.test(input) )
            type = 'observation'
            directionMatch = isDirection.exec(input)
            objectMatch = containsEntity.exec(input)
            if objectMatch then object = objectMatch[0]
            if directionMatch then direction = directionMatch[0]

        if isQuestion.test(input) || isExclamation.test(input)
            type = 'dialog'
            match = containsCharacter.exec(input)
            object = match?[0] || 'implicit'
            tags = helper.tag(input)
            pair = _(tags).filter((pair)-> helper.isNoun(pair[1])).last()
            subject = pair?[0]
            
        if type == 'action' 
            verbs = helper.getVerbs(input)
            nouns = helper.getNouns(input)
            verb = _(verbs).first()
            object = _(nouns).filter((noun)-> noun != verb).last()
            if(not object)
                objectMatch = containsEntity.exec(input)
                object = objectMatch?[0] || 'implicit'
            
        deferred.resolve({
            input: input
            type: type
            isQuestion : isQuestion.test(input)
            isExclamation : isExclamation.test(input)
            subject : subject
            direction : direction
            distance : distance
            unit : unit
            object : object
            verb : verb
        });
    )
    return deferred.promise;
    
   