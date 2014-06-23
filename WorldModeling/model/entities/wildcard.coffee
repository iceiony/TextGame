q = require 'Q'
environment = require './environment'
Character = require '../character'

class Wildcard extends Character
    constructor: ->
        super
            name: "wildcard"
            location: { x: 20, y: 10 }

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
                if intention.isExclamation
                    return @greet(entity)
                if intention.isQuestion
                    return @askAbout(entity, intention.subject, intention.attribute)
                    
                return {
                    input : intention.input
                    type : intention.type
                    text : "Wildcard : #{intention.input}"
                }
            else 
                return {
                    input : intention.input
                    type : intention.type 
                }

module.exports.new = ->
    new Wildcard()