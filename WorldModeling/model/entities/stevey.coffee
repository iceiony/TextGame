q = require 'Q'
Character = require '../character'

class Stevey extends Character
    constructor: ->
        super 
            name : "stevey"
            location  : { x: 20, y: 10 }

    react : (stimuli)->
        if stimuli.subject == 'wildcard' && stimuli.type == 'movement'
            reaction = @move(stimuli.object)
            reaction.reason = 'follow'
            return reaction
            
module.exports.new = -> new Stevey()