Entity = require './entity'
environment = require './entities/environment'
answerRules = require './answer_rules'

class Character extends Entity
    isCharacter: true

    constructor: (options)->
        @knowledge = {} 
        @answerRules = answerRules 
        super options

    referredAs: ->
        capitalName = @name[0].toUpperCase() + @name[1..]
        return capitalName

    answer : (intention)->
        lines = []
        for rule in @answerRules
            lines.push.apply(lines,rule(intention,@knowledge))

        text = @referredAs()+ " : " + lines[0]
        indentation = (new Array(@referredAs().length + 4 )).join(' ')
        for nextSentence in lines[1..]
            text += "\n" + indentation + nextSentence

        return {
            character: @name
            type: "dialog"
            reason: "answer"
            text : text
        }
            
    greet: (characterName)->
        entity = environment.getObjectByName(characterName)
        if @isNear(entity)
            return {
                character: @name
                entity: entity.name
                type:"dialog"
                reason:"greet"
                text: "#{@referredAs()} : Hello #{entity.referredAs()}."
            }
            
    askAbout: (concept,characterName)->
        characterEntity = environment.getObjectByName(characterName)
        if @isNear(characterEntity)
            return {
                character:@name
                entity:characterEntity.name
                type:"dialog"
                reason: "ask"
                concept: concept
                text: "#{@referredAs()} : Tell me about the #{concept} #{characterEntity.referredAs()}."
            }

    move: (entityName)->
        entity = environment.getObjectByName(entityName)

        if not @isNear(entity)
            @location = entity.getLocation()
            return {
            character: @name
            entity: entity.name
            type: "movement"
            reason: "move"
            text: "#{@referredAs()} walks to #{entity.referredAs()}."
            }
        else
            return {
            character: @name
            type: "nothing"
            text: "#{@referredAs()} is already next to #{entity.referredAs()}."
            }

module.exports = Character