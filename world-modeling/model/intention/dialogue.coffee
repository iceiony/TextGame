_ = require 'lodash'
pos = require './../pos_helper'

containsCharacter = require('./helper').containsCharacter
mergeToCurrent = require('./helper').mergeToCurrent

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


entityFromLastQuestionAsked = (lastTextOutput)->
    dialogueLines = _(lastTextOutput.split('\n')).filter( (line)->
        return line.indexOf('  ') == 0 || line.indexOf(" : ") > 0 )

    for line in dialogueLines.reverse().value()
        if (isQuestion.test(line))
            question = true
        if(!question)
            return undefined
        else
        if (containsCharacter.test(line))
            return containsCharacter.exec(line)?[0]
        
module.exports.test = (input)->
    return isQuestion.test(input) || isExclamation.test(input) || isPronounDetected.test(input) || isFreeOfVerbs.test(input) || isStartedByModalWord.test(input)

module.exports.analyse = (input,lastTextOutput)->
    currentResult = 
        input : input
        type : 'dialogue'
        entity : containsCharacter.exec(input)?[0] || entityFromLastQuestionAsked(lastTextOutput) || 'implicit'
        merge: mergeToCurrent

    if isExclamation.test(input)
        return currentResult.merge(subtype : 'exclamation')
    
    currentResult.merge(subtype: 'question')

    adjustedInput = input.replace(/[ ]he /g, " you ").replace(/[ ]is$/g, " are")
    tags = pos.tag(adjustedInput)

    firstVerbIndex = _(tags).findIndex((pair)-> pos.isVerb(pair.tag))
    lastYouIndex = _(tags).findLastIndex((pair)-> isYou.test(pair.word))
    lastNounIndex = _(tags).findLastIndex((pair)-> pos.isNoun(pair.tag) && not containsCharacter.test(pair.word))

    #1 rule: modal question "did you kill him ?"
    if( tags[0].tag == 'MD'  && lastNounIndex < firstVerbIndex  )
        lastVerb = _(tags).filter((pair)-> pos.isVerb(pair.tag)).last()
        return currentResult.merge(
            subject : 'you'
            attribute:lastVerb?.word
        )

    #2 rule: personal question "do you know him ?"
    if (lastYouIndex > firstVerbIndex)
        lastNounOrVerb = _(tags).filter((pair)-> pos.isNoun(pair.tag) || pos.isVerb(pair.tag)).last()
        return currentResult.merge(
            subject:'you'
            attribute: lastNounOrVerb?.word
        )
   
    #3 rule : normal question "ask about the body "
    lastNoun = _(tags).filter((pair)-> pos.isNoun(pair.tag) && not containsCharacter.test(pair.word)).last()
    subject = lastNoun?.word || 'implicit'

    return currentResult.merge(
        subject: subject
    )
