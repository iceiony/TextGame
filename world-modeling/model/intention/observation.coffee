_ = require 'lodash'
helper = require './../pos_helper'

isObservationVerb = /^(inspect|examine|check|analyse|observe|look|search)/
isDirection = /(north|south|east|west|left|right|up|down|around)/

module.exports.test = (input)->
    return isObservationVerb.test(input)

module.exports.analyse = (input)->
    tags = helper.tag(input)
    
    type = 'observation'
    direction = isDirection.exec(input)?[0]
    lastWord = _(tags).last().word
    entity = if helper.isNoun(lastWord) then lastWord else 'implicit'

    return {
    input: input
    type: type
    direction: direction
    entity: entity
    }