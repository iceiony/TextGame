Entity = require './entity'
environment = require './entities/environment'

class Character extends Entity
    isCharacter : true
    
    constructor:(options)->
        super options

    referredAs :->
        capitalName = @name[0].toUpperCase() + @name[1..]
        return capitalName
        
    move :(entityName, deferred)->
        entity = environment.getObjectByName(entityName)
        destination = entity.getLocation()
        if destination.x != @location.x && destination.y != @location.y
            @location = destination
            deferred.resolve("#{@referredAs()} walks to #{entity.referredAs()}.")
        else
            deferred.resolve("#{@referredAs()} is already next to #{entity.referredAs()}.")

module.exports = Character