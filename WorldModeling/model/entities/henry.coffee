q = require 'Q'
Character = require '../character'

class Henry extends Character
    constructor: ->
        super 
            name : "henry"
            location  : { x: 20, y: 10 }

    react : (stimulus)->
        if stimulus.character == 'wildcard' && stimulus.type == 'movement'
            reaction = @move(stimulus.entity)
            reaction.reason = 'follow'
            return reaction

module.exports.new = -> new Henry()