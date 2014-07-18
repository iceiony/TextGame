q = require 'Q'
environment = require './environment'
Character = require '../character'

class Henry extends Character
    constructor: ->
        super 
            name : "henry"
            location  : { x: 20, y: 10 }

        @knowledge =
            'witnesses' : {known:["there's farmer Mark","the two paramedics"]}
            'you' :
                'think' : ["you can talk to some of the witnesses"]

    react : (stimulus)->
        entity = environment.getObjectByName(stimulus.entity)
        if stimulus.character == 'wildcard' && stimulus.type == 'movement'
            reaction = @move(entity)
            reaction.reason = 'follow'
            return reaction

        return super(stimulus)

module.exports.new = -> new Henry()