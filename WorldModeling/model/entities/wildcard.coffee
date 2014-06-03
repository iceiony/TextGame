q = require 'Q'
Character = require '../character'

class Wildcard extends Character
    constructor: ->
        super 
            name : "wildcard"
            location  : { x: 20, y: 10 }
        
    execute:(intention)->
        switch  intention.type
            when 'movement'
                return @move(intention.object)

module.exports.new = -> new Wildcard()