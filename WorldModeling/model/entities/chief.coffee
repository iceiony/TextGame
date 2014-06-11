q = require 'Q'
Character = require '../character'


upperCaseStart = (sentence) ->
    sentence[0].toUpperCase() + sentence[1..]
    
combineParts= (known,questions)->
    sentences = []
    if(known.length + questions.length <= 3 && known.length > 0 && questions.length > 0)
        singleSentence = known.join(' , ')
        singleSentence += " and need to find out " + questions.join(' and ')
        singleSentence += '.'
        sentences.push(singleSentence)
    else
        if known.length > 0
            binder = if known.length > 2 then ' , ' else ' and '
            sentences.push("#{known.join(binder)}.")
        if questions.length > 0
            binder = if questions.length > 2 then ' , ' else ' or '
            sentences.push("We don't know #{questions.join(binder)}.")
    return sentences.map((sentence)-> upperCaseStart(sentence))

class Chief extends Character
    constructor: ->
        super
            name: "chief"
            location: { x: 20, y: 10 }
            
        @knowledge = 
            'case' : {known:["we have a body"] , question:["what happened"]}
            'body' : {known:["middle aged man","found in the middle of nowhere","half naked","he probably died last night"], question:["how the body got here","the cause of death"]}
            'unmatched' : {}
            
    answer: (intention)->
        result = {
            subject: @name
            type: "dialog"
            reason: "answer"
        }
        item = @knowledge[intention.concept]
        item.exhaustCount = item.exhaustCount || 0

        if item.exhaustReset then  clearTimeout(item.exhaustReset)
        item.exhaustReset = setTimeout(->
            console.log 'triggered'
            item.exhaustCount = 0
            item.reminder = true;
            item.knowIndex = 0
            item.questionIndex = 0
        , 5 * 60 * 1000)
        
        if(item.exhaustCount == 0 )
            sentences = []
            knowIndex = item.knowIndex || 0
            knownParts = item.known.slice(knowIndex,knowIndex+3)
            item.knowIndex = knowIndex + knownParts.length
            
            questionIndex = item.questionIndex || 0
            questionParts = item.question.slice(questionIndex,questionIndex+3)
            item.questionIndex = questionIndex + questionParts.length

            if item.reminder
                sentences.push("Like I said.")
                item.reminder = false

            sentences = sentences.concat( combineParts(knownParts, questionParts) )
            
            if (knownParts.length + questionParts.length == 0 )
                item.exhaustCount++
                sentences.push("There isn't anything more I can tell you about it.")
          
            result.text = @referredAs()+ " : " + sentences[0]
            indentation = (new Array(@referredAs().length + 4 )).join(' ')
            for nextSentence in sentences[1..]
                result.text += "\n" + indentation + nextSentence
                
        else
            switch item.exhaustCount
                when 1
                    result.text = "#{@referredAs()} : Listen, I don't know more about the #{intention.concept} than what I told you already"
                when 2
                    result.text = "#{@referredAs()} : Stop it with the darn #{intention.concept} already !"
                when 3
                    result.text = "#{@referredAs()} : If you ask me about the #{intention.concept} one more time I'll dismiss you !"
                when 4
                    result.text = "#{@referredAs()} ignores the request."
                else
                    result.text = "Chief: That's it Wildcard , you're off the case. Go home and take your medication and have a good rest."
            item.exhaustCount++

        return result


    react: (stimulus)->
        if stimulus.subject != 'wildcard'
            return
        switch stimulus.type
            when 'movement'
                reaction = @move(stimulus.object)
                reaction.reason = 'follow'
                return reaction
            when 'dialog'
                switch stimulus.reason
                    when 'ask'
                        return @answer(stimulus)
                    when 'greet'
                        reaction = @greet(stimulus.subject)
                        reaction.reason = 'greet'
                        return reaction

module.exports.new = ->
    new Chief()