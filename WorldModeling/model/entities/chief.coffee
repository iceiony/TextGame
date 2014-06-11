q = require 'Q'
Character = require '../character'

class Chief extends Character
    constructor: ->
        super
            name: "chief"
            location: { x: 20, y: 10 }
            
        @knowledge = 
            'case' : {concrete:["we have a body"] , question:["what happened"]}
            'body' : {concrete:["middle aged man","found in the middle of nowhere","half naked","he probably died last night"], question:["how the body got here","the cause of death"]}
            'unmatched' : {}

    answer: (intention)->
        result = {
            subject: @name
            type: "dialog"
            reason: "answer"
            text : ""
        }
        item = @knowledge[intention.concept];

        knowIndex = item.knowIndex || 0
        knownParts = item.concrete.slice(knowIndex,knowIndex+3)
        if knownParts.length > 0
            item.knowIndex = knowIndex + knownParts.length
            binder = if knownParts.length > 2 then ' , ' else ' and '
            known = knownParts.join(binder)
            known = known[0].toUpperCase() + known[1..]
            result.text = "#{@referredAs()} : #{known}."

        questionIndex = item.questionIndex || 0
        questionParts = item.question.slice(questionIndex,questionIndex+3)
        if questionParts.length > 0 
            item.questionIndex = questionIndex + questionParts.length 
            indentation = (new Array(@referredAs().length + 4 )).join(' ')
            binder = if questionParts.length > 2 then ' , ' else ' and ' 
            question = questionParts.join(binder)
            result.text += "\n#{indentation}We don't know #{question}."
        
        if result.text.length == 0 
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