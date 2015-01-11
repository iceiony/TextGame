q = require 'q'
environment = require './environment'
Character = require '../character'


class Stevey extends Character
    constructor: ->
        super 
            name : "stevey"
            location  : { x: 20, y: 10 }

        @knowledge =
            'you' :
                'think' : ["you have no idea what you are doing"]
                'rude' : [""]

    react : (stimulus)->
        entity = environment.getObjectByName(stimulus.entity)
        if stimulus.character == 'wildcard' && stimulus.type == 'movement'
            reaction = @move(entity,stimulus)
            reaction.reason = 'follow'
            return reaction

        return super(stimulus)
            
module.exports.new = -> new Stevey()