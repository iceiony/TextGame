q = require 'Q'
Character = require '../character'

class Wildcard extends Character
    constructor: ->
        super 
            name : "wildcard"
            location  : { x: 20, y: 10 }
        
    executeAsync:(intention)->
        deferred = q.defer()
        
        switch  intention.type
            when 'movement' then @move(intention.object, deferred)
    
        deferred.promise

module.exports.new = -> new Wildcard()