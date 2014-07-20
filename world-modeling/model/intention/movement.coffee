_ = require 'lodash'
pos = require './../pos_helper'
containsEntity = require('./helper').containsEntity

isDirection = /(north|south|east|west|left|right|up|down|around)/
isMovementVerb = /^(go|walk|move|jump|sprint|step|run) /
distanceAndMetric = /(\d+ ?[a-zA-Z]*|\d+ ?[a-zA-Z]*)( |$)/



module.exports.test = (input)->
    return isMovementVerb.test(input)

module.exports.analyse = (input)->
    type = 'movement'
    unit = 'meters'
    distance = 10

    nouns = pos.getNouns(input)
    entity = containsEntity.exec(input)?[0] || _(nouns).last()
    
    if distanceAndMetric.test(input)
        distanceString = distanceAndMetric.exec(input)[0].trim()
        unit = /[a-zA-Z]+/.exec(distanceString)[0]
        distance = parseInt(/\d+/.exec(distanceString)[0])
        
    return {
    input: input
    type : type
    entity : entity
    distance: distance
    unit : unit
    isDirection : isDirection.test(entity)
    }