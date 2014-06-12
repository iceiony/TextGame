q = require 'Q'
Character = require '../character'

class Chief extends Character
    constructor: ->
        super
            name: "chief"
            location: { x: 20, y: 10 }
            
        @knowledge = 
            'case' : {known:["we have a body"] , question:["what happened"]}
            'body' : {known:["middle aged man","found in the middle of nowhere","half naked","he probably died last night"], question:["how the body got here","the cause of death"]}
            'unmatched' : {}

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

module.exports.new = -> new Chief()