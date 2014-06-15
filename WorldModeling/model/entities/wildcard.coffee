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
        switch  intention.type
            when 'movement'
                return @move(entity)
            when 'dialog'
                if not @isNear(entity)
                    return requires: {
                        entity: intention.entity
                        type: 'movement'
                    }

                if intention.isExclamation
                    return @greet(entity)
                if intention.isQuestion
                    return @askAbout(entity, intention.subject, intention.attribute)

module.exports.new = ->
    new Wildcard()