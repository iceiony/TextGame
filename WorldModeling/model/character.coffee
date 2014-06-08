Entity = require './entity'
environment = require './entities/environment'

class Character extends Entity
    isCharacter: true

    constructor: (options)->
        super options

    referredAs: ->
        capitalName = @name[0].toUpperCase() + @name[1..]
        return capitalName
        
    greet: (entityName)->
        entity = environment.getObjectByName(entityName)
        if @isNear(entity)
            return {
                subject: @name
                object: entity.name
                type:"dialog"
                reason:"greet"
                text: "#{@referredAs()}: Hello #{entity.referredAs()}."
            }

    getKnowledgeKeys: ()->
        return ['name','body','case']

    move: (entityName)->
        entity = environment.getObjectByName(entityName)

        if not @isNear(entity)
            @location = entity.getLocation()
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