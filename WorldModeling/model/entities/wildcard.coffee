q = require 'Q'
environment = require './../entities/environment'

class Wildcard
    constructor: ->
        @name = "wildcard"
        @currentLocation = { x: 20, y: 10 }
    referredAs: ->
        "Wildcard"
    getLocation: ->
        @currentLocation

    move :(entityName, deferred)->
        entity = environment.getObjectByName(entityName)
        destination = entity.getLocation()
        if destination.x != @currentLocation.x && destination.y != @currentLocation.y
            @currentLocation = destination
            deferred.resolve("Wildcard walks to #{entity.referredAs()}.")
        else
            deferred.resolve("Wildcard is already next to #{entity.referredAs()}.")    
        
    executeAsync:(intention)->
        deferred = q.defer()
        
        switch  intention.type
            when 'movement' then @move(intention.object, deferred)
    
        deferred.promise

module.exports.new = -> new Wildcard()