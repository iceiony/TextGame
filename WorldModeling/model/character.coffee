Entity = require './entity'
environment = require './entities/environment'

class Character extends Entity
    isCharacter: true

    constructor: (options)->
        super options

    referredAs: ->
        capitalName = @name[0].toUpperCase() + @name[1..]
        return capitalName
        
    move: (entityName)->
        entity = environment.getObjectByName(entityName)
        destination = entity.getLocation()

        if destination.x != @location.x && destination.y != @location.y
            @location = destination
            return {
            subject: @name
            object: entity.name
            type: "movement"
            reason: "move"
            text: "#{@referredAs()} walks to #{entity.referredAs()}."
            }
        else
            return {
            subject: @name
            type: "nothing"
            text: "#{@referredAs()} is already next to #{entity.referredAs()}."
            }

module.exports = Character