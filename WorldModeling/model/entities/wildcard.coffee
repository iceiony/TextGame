q = require 'Q'
environment = require './environment'
Character = require '../character'

class Wildcard extends Character
    constructor: ->
        super
            name: "wildcard"
            location: { x: 20, y: 10 }

    dialogue: (entity, intention)->
        console.log intention
        switch(intention.subtype)
            when 'exclamation'
                return @greet(entity)
            when 'question'
                return @askAbout(entity, intention.subject, intention.attribute)
            else
                return {
                input: intention.input
                type: intention.type
                text: "Wildcard : #{intention.input}"
                }
            
    execute: (intention)->
        entity = environment.getObjectByName(intention.entity)

        if intention.type != 'movement' && entity && not @isNear(entity)
            return requires: {
                input : "go to #{intention.entity}"
                entity: intention.entity
                type: 'movement'
            }
        
        switch  intention.type
            when 'movement'
                return @move(entity)
            when 'dialogue'
                return @dialogue(entity,intention)
            when 'silence'
                return {
                    input : ""
                    type : intention.type 
                    text : "Wildcard does nothing."
                }
            else 
                return {
                    input : intention.input
                    type : intention.type 
                }

module.exports.new = ->
    new Wildcard()