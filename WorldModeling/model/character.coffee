Entity = require './entity'
environment = require './entities/environment'
answerRules = require './answer_rules'
helper = require './pos_helper'

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
            
    askAbout: (characterName,subject,attribute)->
        characterEntity = environment.getObjectByName(characterName)
        if not @isNear(characterEntity) then return

        if attribute == undefined 
            text = "#{@referredAs()} : Tell me about the #{subject} #{characterEntity.referredAs()}."
        if attribute != undefined && helper.isVerb(attribute)
            text = "#{@referredAs()} : What do you #{attribute} #{characterEntity.referredAs()} ?"
        if attribute != undefined && helper.isNoun(attribute)
            text = "#{@referredAs()} : What is your #{attribute} #{characterEntity.referredAs()} ?"
            
        return {
            character:@name
            entity:characterEntity.name
            type:"dialog"
            reason: "ask"
            subject: subject
            attribute : attribute
            text: text
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