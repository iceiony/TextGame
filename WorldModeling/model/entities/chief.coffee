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
        item = @knowledge[intention.concept];

        knowIndex = item.knowIndex || 0
        knownParts = item.known.slice(knowIndex,knowIndex+3)
        item.knowIndex = knowIndex + knownParts.length
        
        questionIndex = item.questionIndex || 0
        questionParts = item.question.slice(questionIndex,questionIndex+3)
        item.questionIndex = questionIndex + questionParts.length

        sentences = combineParts(knownParts,questionParts)

        if (sentences.length > 0 )
            result.text = @referredAs()+ " : " + sentences[0]
            indentation = (new Array(@referredAs().length + 4 )).join(' ')
            for nextSentence in sentences[1..]
                result.text += "\n" + indentation + nextSentence
        else
            result.text = "#{@referredAs()} : There isn't anything more I can tell you about it."

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