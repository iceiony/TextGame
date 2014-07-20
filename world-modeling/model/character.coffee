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

        name = @referredAs()[0].toUpperCase() + @referredAs()[1..]
        text = name + " : " + lines[0]
        indentation = (new Array(@referredAs().length + 4 )).join(' ')
        for nextSentence in lines[1..]
            text += "\n" + indentation + nextSentence

        return {
            character: @name
            type: "dialogue"
            reason: "answer"
            text : text
        }
            
    greet: (entity)->
            return {
                character: @name
                entity: entity.name
                type:"dialogue"
                reason:"greet"
                text: "#{@referredAs()} : Hello #{entity.referredAs()}."
            }
            
    askAbout: (characterEntity,subject,attribute,intention)->
        
        if attribute == undefined 
            text = "#{@referredAs()} : Tell me about the #{subject} #{characterEntity.referredAs()}."
        if attribute != undefined && helper.isVerb(attribute)
            text = "#{@referredAs()} : What do you #{attribute} #{characterEntity.referredAs()} ?"
        if attribute != undefined && helper.isNoun(attribute)
            text = "#{@referredAs()} : What is your #{attribute} #{characterEntity.referredAs()} ?"
        if subject == 'you' && attribute == 'are' 
            text = "#{@referredAs()} : How are you ?"
            
        text = text || "#{@referredAs()} : #{intention.input[0].toUpperCase() + intention.input[1..]}"
            
        return {
            character:@name
            entity:characterEntity.name
            type:"dialogue"
            subtype : intention.subtype
            reason: "ask"
            subject: subject
            attribute : attribute
            text: text
        }

    move: (entity,intention)->
        if not entity 
            if (intention.isDirection)
                return {
                character: @name
                entity: intention.entity
                distance : intention.distance
                unit : intention.unit
                isDirection : true
                reason: "move"
                type : "movement"
                text : "#{@referredAs()} walks #{intention.entity} #{intention.distance} #{intention.unit}."
                }
            if (intention.entity)
                return {
                    character: @name
                    type : "nothing"
                    text : "There is no #{intention.entity} around to walk to."
                }

        
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
   
    react: (stimulus)->
        if stimulus.type == 'dialogue' &&
         ( stimulus.entity == @name || stimulus.entity in @aliases )
            
            entity = environment.getObjectByName(stimulus.character)
            switch stimulus.reason
                when 'ask'
                    return @answer(stimulus)
                when 'greet'
                    reaction = @greet(entity)
                    reaction.reason = 'greet'
                    return reaction

        
module.exports = Character