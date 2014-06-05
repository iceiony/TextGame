q = require 'Q'
Character = require '../character'

class Henry extends Character
    constructor: ->
        super 
            name : "henry"
            location  : { x: 20, y: 10 }

    react : (stimuli)->
        if stimuli.subject == 'wildcard' && stimuli.type == 'movement'
            reaction = @move(stimuli.object)
            reaction.reason = 'follow'
            return reaction

module.exports.new = -> new Henry()