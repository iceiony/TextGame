_ = require 'lodash'
pos = require './../pos_helper'

containsCharacter = require('./helper').containsCharacter

isQuestion = /\?|what |where |why |how |ask |tell |did |are you/
isExclamation = /(hi|hello|howdy|greetings|!)( .*|$)/
isPronounDetected = /(you|your|my|me|i) /
isYou = /(you|your)/


isFreeOfVerbs = 
    test : (input)->
        pos.getVerbs(input).length == 0

isStartedByModalWord =
    test : (input)->
        tags = pos.tag(input)
        tags[0].tag == 'MD'


module.exports.test = (input)->
    return isQuestion.test(input) || isExclamation.test(input) || isPronounDetected.test(input) || isFreeOfVerbs.test(input) || isStartedByModalWord.test(input)

module.exports.analyse = (input)->
    currentResult = 
        input : input
        type : 'dialogue'
        entity : containsCharacter.exec(input)?[0] || 'implicit'

    if isExclamation.test(input)
        return currentResult.merge(subtype : 'exclamation')
    
    currentResult.merge(subtype: 'question')

    adjustedInput = input.replace(/[ ]he /g, " you ").replace(/[ ]is$/g, " are")
    tags = pos.tag(adjustedInput)

    firstVerbIndex = _(tags).findIndex((pair)-> pos.isVerb(pair.tag))
    lastYouIndex = _(tags).findLastIndex((pair)-> isYou.test(pair.word))
    lastNounIndex = _(tags).findLastIndex((pair)-> pos.isNoun(pair.tag) && not containsCharacter.test(pair.word))

    if( tags[0].tag == 'MD' || tags[0].word == 'did' ) && (lastNounIndex < 0 || lastNounIndex < firstVerbIndex  )
        lastVerb = _(tags).filter((pair)-> pos.isVerb(pair.tag)).last()
        return currentResult.merge(
            subject : 'you'
            attribute:lastVerb?.word
        )

    if (lastYouIndex > firstVerbIndex)
        lastNounOrVerb = _(tags).filter((pair)-> pos.isNoun(pair.tag) || pos.isVerb(pair.tag)).last()
        return currentResult.merge(
            subject:'you'
            attribute: lastNounOrVerb?.word
        )
   
        
    lastNoun = _(tags).filter((pair)-> pos.isNoun(pair.tag) && not containsCharacter.test(pair.word)).last()
    subject = lastNoun?.word || 'implicit'

    return currentResult.merge(
        subject: subject
    )
