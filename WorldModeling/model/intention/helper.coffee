entities = require('./../entities/environment').getAllEntityNames()
characters = require('./../entities/environment').getAllCharacterNames()

entitiesRegexString = "(#{entities.join('|')})".toLowerCase()
containsEntity = new RegExp(entitiesRegexString)

charactersRegexString = "(#{characters.join('|')})".toLowerCase()
containsCharacter = new RegExp(charactersRegexString)

Object.prototype.merge = (otherObject)->
    for key,value of otherObject
        @[key] = value
    return @

module.exports.containsEntity = containsEntity
module.exports.containsCharacter = containsCharacter 