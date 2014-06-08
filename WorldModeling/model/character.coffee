Entity = require './entity'
environment = require './entities/environment'

class Character extends Entity
    isCharacter: true

    constructor: (options)->
        super options

    referredAs: ->
        capitalName = @name[0].toUpperCase() + @name[1..]
        return capitalName
        
    greet: (characterName)->
        entity = environment.getObjectByName(characterName)
        if @isNear(entity)
            return {
                subject: @name
                object: entity.name
                type:"dialog"
                reason:"greet"
                text: "#{@referredAs()} : Hello #{entity.referredAs()}."
            }
            
    askAbout: (concept,characterName)->
        characterEntity = environment.getObjectByName(characterName)
        if @isNear(characterEntity)
            return {
                subject:@name
                object:characterEntity.name
                type:"dialog"
                reason: "ask"
                concept: concept
                text: "#{@referredAs()} : Tell me about the #{concept} #{characterEntity.referredAs()}."
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