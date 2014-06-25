_ = require 'lodash'
q = require 'Q'
helper = require './../pos_helper'

silence = require './silence'
movement = require './movement'
observation = require './observation'

characters = require('./../entities/environment').getAllCharacterNames()

isQuestion = /\?|what |where |why |how |ask |can you |tell |did |are you/
isExclamation = /(hi|hello|howdy|greetings|!)( .*|$)/
isPronounDetected = /(you|your|my|me|i) /
isYou = /(you|your)/

containsEntity = require('./helper').containsEntity

charactersRegexString = "(#{characters.join('|')})".toLowerCase()
containsCharacter = new RegExp(charactersRegexString)




module.exports.interpretAsync = (input)-> 
    deferred = q.defer()
    input = input.trim().toLowerCase()

    setImmediate(->
        
        if (silence.test(input))
            deferred.resolve(silence.analyse(input))
            return

        if (observation.test(input))
            deferred.resolve(observation.analyse(input))
            return

        if (movement.test(input))
            deferred.resolve(movement.analyse(input))
            return 
        
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
                
        if isQuestion.test(input) || isExclamation.test(input) || isPronounDetected.test(input) || (verbs = helper.getVerbs(input)).length == 0 || tags[0].tag == 'MD'
            type = 'dialogue'
            entity = containsCharacter.exec(input)?[0] || 'implicit'

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
    
   