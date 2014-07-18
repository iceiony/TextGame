posHelper = require './pos_helper'
helper =
    upperCaseStart: (sentence) ->
        sentence[0].toUpperCase() + sentence[1..]

    combineParts: (known, questions)->
        lines = []
        if(known.length + questions.length <= 3 && known.length > 0 && questions.length > 0)
            singleSentence = known.join(' , ')
            singleSentence += " and need to find out " + questions.join(' and ')
            singleSentence += '.'
            lines.push(singleSentence)
        else
            if known.length > 0
                binder = if known.length > 2 then ' , ' else ' and '
                lines.push("#{known.join(binder)}.")
            if questions.length > 0
                binder = if questions.length > 2 then ' , ' else ' or '
                lines.push("We don't know #{questions.join(binder)}.")
        return lines.map((sentence)->
            helper.upperCaseStart(sentence))

    retrieve: (subject, knowledge)->
        if knowledge[subject] == undefined
            knowledge['unmatched'] = knowledge['unmatched'] || {}
            item = knowledge['unmatched'][subject] || {}
            knowledge['unmatched'][subject] = item
        else
            item = knowledge[subject]
            item.knowIndex = item.knowIndex || 0
            item.questionIndex = item.questionIndex || 0
        item.exhaustCount = item.exhaustCount || 0
        return item

    setExhaustReset: (item)->
        if item.exhaustReset then  clearTimeout(item.exhaustReset)
        item.exhaustReset = setTimeout(->
            item.reminder = true
            item.exhaustCount = 0
            item.knowIndex = 0
            item.questionIndex = 0
        , 5 * 60 * 1000)


answerUnknown = (intention, knowledge)->
    if knowledge[intention.subject] != undefined ||
        intention.subject == 'you' 
    then return

    item = helper.retrieve(intention.subject, knowledge)
    item.exhaustCount++
    switch item.exhaustCount
        when 1 
            return ["What are you talking about ?"]
        when 2
            return ["What does that have to do with anything ?"]
        when 3
            return ["What is it with you and the #{intention.subject} ?"]
        else
            return ["No !"]

answerAnnoyed = (intention, knowledge)->
    if knowledge[intention.subject] == undefined then return
    item = helper.retrieve(intention.subject, knowledge)
    if item.exhaustCount == 0 then return

    item.exhaustCount++
    switch item.exhaustCount
        when 2
            return ["Listen, I don't know more about the #{intention.subject} than what I told you already"]
        when 3
            return ["Stop it with the darn #{intention.subject} already !"]
        when 4
            return ["If you ask me about the #{intention.subject} one more time you'll be dismissed !"]
        when 5
            return ["ignores the request."]
        else
            return ["That's it Wildcard , you're off the case. Go home and take your medication and have a good rest."]


answerKnown = (intention, knowledge) ->
    if  intention.subject == 'you' ||
        intention.attribute != undefined ||
        knowledge[intention.subject] == undefined
        then return
    
    item = helper.retrieve(intention.subject, knowledge)
    if item.exhaustCount > 0 then return

    lines = []
    helper.setExhaustReset(item)
    if item.reminder
        lines.push("Like I said.")
        item.reminder = false

    knownParts = item.known.slice(item.knowIndex, item.knowIndex + 3)
    questionParts = item.question?.slice(item.questionIndex, item.questionIndex + 3) || []
    item.knowIndex += knownParts.length
    item.questionIndex += questionParts.length 

    lines.push.apply(lines, helper.combineParts(knownParts, questionParts))

    if (knownParts.length + questionParts.length == 0 )
        lines.push("There isn't anything more I can tell you about it.")
        item.exhaustCount++

    return lines

answerAboutSelf = (intention,knowledge)->
    if intention.subject != 'you' && intention.attribute == undefined
        return

    item = knowledge[intention.subject]?[intention.attribute]
    
    if item == undefined 
        return ["I can't tell you that. It's personal."]
        
    description = item.shift()
    item.push(description)

    if ( intention.attribute == 'are') 
        return ["I am #{description}."]
    
    if posHelper.isVerb(intention.attribute)
        return ["I #{intention.attribute} #{description}."]
    else 
        return ["My #{intention.attribute} is #{description}."]
        
    
module.exports = [
    answerUnknown
    answerAnnoyed
    answerKnown
    answerAboutSelf
]