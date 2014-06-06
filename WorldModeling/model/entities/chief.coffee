q = require 'Q'
Character = require '../character'

class Chief extends Character
    constructor: ->
        super 
            name : "chief"
            location  : { x: 20, y: 10 }
            
    react : (stimulus)->
        if stimulus.subject == 'wildcard' && stimulus.type == 'movement'
            reaction = @move(stimulus.object)
            reaction.reason = 'follow'
            return reaction
module.exports.new = -> new Chief()