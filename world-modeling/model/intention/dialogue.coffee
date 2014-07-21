_ = require 'lodash'
pos = require './../pos_helper'

containsCharacter = require('./helper').containsCharacter
mergeToCurrent = require('./helper').mergeToCurrent

isQuestion = /\?|^what |^where |^why |^how |ask |tell |did |are you/
isExclamation = /(^hi($| )|hello|howdy|greetings|(ha)+|^gah|!)( .*|$)/
isPronounDetected = /(^| )(you|your|my|me|i|he) /
isYou = /(you|your)/
isStartedByStatementWord = /^(good|aham|aha|ahem|ah |very|not |been) /


isFreeOfVerbs = 
    test : (input)->
        pos.getVerbs(input).length == 0

isStartedByModalWord =
    test : (input)->
        tags = pos.tag(input)
        tags[0].tag == 'MD'

isStartedByDeterminant = 
    test : (input)->
        tags = pos.tag(input)
        tags[0].tag == 'DT'


isSingleWordAnswerToQuestion = (input,lastTextOutput)->
    return entityFromLastQuestionAsked(lastTextOutput) && pos.tag(input).length == 1 
        

entityFromLastQuestionAsked = (lastTextOutput)->
    dialogueLines = _(lastTextOutput.split('\n'))
        .filter( (line)->
            return line.indexOf('  ') == 0 || 
                line.indexOf(": ") > 0 
    )
    for line in dialogueLines.reverse().value()
        if (isQuestion.test(line))
            question = true
        if(!question)
            return undefined
        else
            if (containsCharacter.test(line))
                return containsCharacter.exec(line)?[0]

extractTopicOfInterest = (tags)->
    indirectionIndex = _(tags).findLastIndex((pair)-> pair.tag == 'IN' )
    if indirectionIndex == tags.length - 1
        indirectionIndex-- #the object referred is in front of the indirection

    if ( indirectionIndex > 0 )
        #1 rule : normal question or statement that has a subject and a determinant "ask about the body " "tell me about mark"
        interest = _(tags[indirectionIndex..])
        .filter((pair)->pos.isNoun(pair.tag) || pos.isVerb(pair.tag))
        .first()
    else
        #2 normal question or statement that has a subject "where is the body?" 
        interest = _(tags).filter((pair)-> not containsCharacter.test(pair.word))
        .select((pair,index,array)-> index >= array.length - 2 )
        .filter((pair)-> pos.isNoun(pair.tag) || pos.isVerb(pair.tag))
        .last()
        
    return interest?.word
    
extractCharacterDirectedAt= (input)->
    character = containsCharacter.exec(input)?[0] 
    if character
        noSubjectInput = input.replace('about '+character,"") #handle situation where question is about a character
        character = containsCharacter.exec(noSubjectInput)?[0]
    return character 

module.exports.test = (input,lastTextOutput)->
    return isQuestion.test(input) || 
        isExclamation.test(input) || 
        isPronounDetected.test(input) || 
        isFreeOfVerbs.test(input) || 
        isStartedByModalWord.test(input) ||
        isStartedByDeterminant.test(input) ||
        isStartedByStatementWord.test(input) ||
        isSingleWordAnswerToQuestion(input,lastTextOutput)

module.exports.analyse = (input,lastTextOutput)->
    adjustedInput = input.replace(/[ ]he /g, " you ").replace(/[ ]is$/g, " are")
    tags = pos.tag(adjustedInput)
    
    currentResult = 
        input : input
        type : 'dialogue'
        entity : extractCharacterDirectedAt(input) || entityFromLastQuestionAsked(lastTextOutput) || 'implicit'
        merge: mergeToCurrent

    if isExclamation.test(input)
        return currentResult.merge(subtype : 'exclamation')
    
    currentResult.merge(subtype: 'question')
    
    firstVerbIndex = _(tags).findIndex((pair)-> pos.isVerb(pair.tag))
    lastYouIndex = _(tags).findLastIndex((pair)-> isYou.test(pair.word))
    lastNounIndex = _(tags).findLastIndex((pair)-> pos.isNoun(pair.tag) && not containsCharacter.test(pair.word))

    #1 rule: modal question "did you kill him ?"
    if( tags[0].tag == 'MD' && tags[1].tag == 'PRP' && lastNounIndex < firstVerbIndex  )
        lastVerb = _(tags).filter((pair)-> pos.isVerb(pair.tag)).last()
        return currentResult.merge(
            subject : 'you'
            attribute:lastVerb?.word
        )

    #2 rule: personal question "do you know him ?"
    if (lastYouIndex > firstVerbIndex)
        topicOfInterest = extractTopicOfInterest(tags)

        return currentResult.merge(
            subject:'you'
            attribute: topicOfInterest || "implicit"
        )
        
        
    #3.3 normal question or statement
    interest = extractTopicOfInterest(tags)
    subject = interest || 'implicit'

    #4 rule : contains personal pronoun but is not a question
    if !isQuestion.test(input) 
        currentResult.merge(subtype : 'statement')
    

    return currentResult.merge(
        subject: subject
    )
