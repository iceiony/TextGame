entities = require('./../entities/environment').getAllEntityNames()
characters = require('./../entities/environment').getAllCharacterNames()

entitiesRegexString = "(#{entities.join('|')})".toLowerCase()
containsEntity = new RegExp(entitiesRegexString)

charactersRegexString = "(#{characters.join('|')})".toLowerCase()
containsCharacter = new RegExp(charactersRegexString)

merge = (otherObject)->
    for key,value of otherObject
        @[key] = value
    return @

module.exports.mergeToCurrent = merge
module.exports.containsEntity = containsEntity
module.exports.containsCharacter = containsCharacter 