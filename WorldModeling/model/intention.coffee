_ = require 'lodash'
q = require 'Q'
helper = require './pos_helper'


entities = require('./entities/environment').getAllEntityNames()
characters = require('./entities/environment').getAllCharacterNames()

isQuestion = /\?|what |where |why |how |ask |can you |tell |did |are you/
isExclamation = /(hi|hello|howdy|greetings|!)( .*|$)/
isPronounDetected = /(you|your|my|me|i) /
isYou = /(you|your)/

entitiesRegexString = "(#{entities.join('|')})".toLowerCase()
containsEntity = new RegExp(entitiesRegexString)

charactersRegexString = "(#{characters.join('|')})".toLowerCase()
containsCharacter = new RegExp(charactersRegexString)

isDirection = /(north|south|east|west|left|right|up|down|around)/
isMovementVerb = /^(go|walk|move|jump|sprint|step|run)/
distanceAndMetric = /(\d+ ?[a-zA-Z]*|\d+ ?[a-zA-Z]*)( |$)/

isObservationVerb = /^(inspect|examine|check|analyse|observe|look|search)/


module.exports.interpretAsync = (input)-> 
    deferred = q.defer()
    input = input.toLowerCase()

    setImmediate(->
        direction = undefined 
        entity = undefined
        distance = undefined
        subject = undefined
        attribute = undefined 
        unit = undefined
        verb = undefined
        
        adjustedInput = input.replace(/[ ]he /g," you ")
                             .replace(/[ ]is$/g," are")
        tags = helper.tag(adjustedInput)

        if (verbs = helper.getVerbs(input)).length > 0
            type = 'action'
            nouns = helper.getNouns(input)
            verb = _(verbs).first()
            entity = _(nouns).filter((noun)-> noun != verb).last()
            if(not entity)
                entity = containsEntity.exec(input)?[0] || 'implicit'
        
        if isMovementVerb.test(input) && ( isDirection.test(input) || containsEntity.test(input) )
            type = 'movement'
            distance = 'implicit'
            entity = containsEntity.exec(input)?[0]
            if distanceAndMetric.test(input)
                distanceString = distanceAndMetric.exec(input)[0].trim()
                unit = /[a-zA-Z]+/.exec(distanceString)[0]
                distance = parseInt(/\d+/.exec(distanceString)[0])
            

        if isObservationVerb.test(input)
            type = 'observation'
            direction = isDirection.exec(input)?[0]
            lastWord  = _(tags).last().word
            lastNounWord = if helper.isNoun(lastWord) then lastWord
            entity = lastNounWord || 'implicit'
            
        if isQuestion.test(input) || isExclamation.test(input) || isPronounDetected.test(input) || (verbs = helper.getVerbs(input)).length == 0 || tags[0].tag == 'MD'
            type = 'dialogue'
            character = containsCharacter.exec(input)?[0]
            entity = character || 'implicit'

            lastYouIndex = _(tags).findLastIndex((pair)-> isYou.test(pair.word))
            lastNounIndex = _(tags).findLastIndex((pair)-> helper.isNoun(pair.tag) && pair.word not in characters )
            verbIndex = _(tags).findIndex((pair)-> helper.isVerb(pair.tag))
            if (lastYouIndex > verbIndex)
                subject = 'you'
                lastNounOrVerb = _(tags).filter((pair)-> helper.isNoun(pair.tag) || helper.isVerb(pair.tag) ).last()
                attribute = lastNounOrVerb?.word
            else 
                lastNoun = _(tags).filter((pair)-> helper.isNoun(pair.tag))
                                  .filter((pair)-> pair.word not in characters ).last()
                subject = lastNoun?.word || 'implicit'

            if( tags[0].tag == 'MD' || tags[0].word == 'did' ) && (lastNounIndex < 0 || lastNounIndex < verbIndex  )
                subject = 'you'
                lastVerb = _(tags).filter((pair)-> helper.isVerb(pair.tag)).last()
                attribute = lastVerb?.word
            
            
        deferred.resolve({
            input: input
            type: type
            
            isQuestion : isQuestion.test(input)
            isExclamation : isExclamation.test(input)
            subject : subject
            attribute : attribute

            entity : entity
            direction : direction
            distance : distance
            unit : unit
            verb : verb
        });
    )
    return deferred.promise;
    
   