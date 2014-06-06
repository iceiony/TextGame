q = require 'Q'
Character = require '../character'

class Chief extends Character
    constructor: ->
        super 
            name : "chief"
            location  : { x: 20, y: 10 }
            
    react : (stimulus)->
        if stimulus.subject != 'wildcard'
            return
            
        switch stimulus.type 
                when 'movement'
                    reaction = @move(stimulus.object)
                    reaction.reason = 'follow'
                    return reaction
                when 'dialog'
                    reaction = @greet(stimulus.subject)
                    reaction.reason = 'greet'
                    return reaction
        
module.exports.new = -> new Chief()