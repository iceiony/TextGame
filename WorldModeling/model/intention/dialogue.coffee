_ = require 'lodash'
helper = require './../pos_helper'

containsCharacter = require('./helper').containsCharacter

isQuestion = /\?|what |where |why |how |ask |can you |tell |did |are you/
isExclamation = /(hi|hello|howdy|greetings|!)( .*|$)/
isPronounDetected = /(you|your|my|me|i) /
isYou = /(you|your)/


module.exports.test = (input)->
    adjustedInput = input.replace(/[ ]he /g, " you ")
                         .replace(/[ ]is$/g, " are")
    tags = helper.tag(adjustedInput)
    
    return isQuestion.test(input) || isExclamation.test(input) || isPronounDetected.test(input) || helper.getVerbs(input).length == 0 || tags[0].tag == 'MD'

module.exports.analyse = (input)->
    adjustedInput = input.replace(/[ ]he /g, " you ")
                         .replace(/[ ]is$/g, " are")
    tags = helper.tag(adjustedInput)

    type = 'dialogue'
    entity = containsCharacter.exec(input)?[0] || 'implicit'

    lastYouIndex = _(tags).findLastIndex((pair)-> isYou.test(pair.word))
    lastNounIndex = _(tags).findLastIndex((pair)-> helper.isNoun(pair.tag) && not containsCharacter.test(pair.word))

    verbIndex = _(tags).findIndex((pair)-> helper.isVerb(pair.tag))
    if (lastYouIndex > verbIndex)
        subject = 'you'
        lastNounOrVerb = _(tags).filter((pair)-> helper.isNoun(pair.tag) || helper.isVerb(pair.tag)).last()
        attribute = lastNounOrVerb?.word
    else
        lastNoun = _(tags).filter((pair)-> helper.isNoun(pair.tag))
                          .filter((pair)-> not containsCharacter.test(pair.word)).last()
        subject = lastNoun?.word || 'implicit'

    if( tags[0].tag == 'MD' || tags[0].word == 'did' ) && (lastNounIndex < 0 || lastNounIndex < verbIndex  )
        subject = 'you'
        lastVerb = _(tags).filter((pair)-> helper.isVerb(pair.tag)).last()
        attribute = lastVerb?.word

    return {
    input: input
    type: type
    entity: entity
    subject: subject
    attribute: attribute

    isQuestion: isQuestion.test(input)
    isExclamation: isExclamation.test(input)
    }
