q = require 'Q'
environment = require './environment'
Character = require '../character'


class Stevey extends Character
    constructor: ->
        super 
            name : "stevey"
            location  : { x: 20, y: 10 }

    react : (stimulus)->
        entity = environment.getObjectByName(stimulus.entity)
        if stimulus.character == 'wildcard' && stimulus.type == 'movement'
            reaction = @move(entity)
            reaction.reason = 'follow'
            return reaction
            
module.exports.new = -> new Stevey()