_ = require 'lodash'
helper = require './../pos_helper'
containsEntity = require('./helper').containsEntity

module.exports.test = (input)->
    return helper.getVerbs(input).length > 0
    
module.exports.analyse = (input)->
    type = 'action'
    verbs = helper.getVerbs(input)
    nouns = helper.getNouns(input)
    verb = _(verbs).first()
    entity = _(nouns).filter((noun)-> noun != verb).last()
    if(not entity)
        entity = containsEntity.exec(input)?[0] || 'implicit'
        
    return {
        input :input
        type: type
        entity : entity
        verb : verb        
    }