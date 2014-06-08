q = require 'Q'
Character = require '../character'

class Chief extends Character
    constructor: ->
        super
            name: "chief"
            location: { x: 20, y: 10 }

    answer: (question)->
        result = {
            subject: @name
            type: "dialog"
            reason: "answer"
        }
        switch question.concept
            when 'body'
                result.text = "Chief : There isn't anything more I can tell you about it."
            when 'case'
                result.text = "Chief : Like I said, we have a body and we don't know where it came from."
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