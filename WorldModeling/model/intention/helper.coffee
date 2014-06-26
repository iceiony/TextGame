entities = require('./../entities/environment').getAllEntityNames()
characters = require('./../entities/environment').getAllCharacterNames()

entitiesRegexString = "(#{entities.join('|')})".toLowerCase()
containsEntity = new RegExp(entitiesRegexString)

charactersRegexString = "(#{characters.join('|')})".toLowerCase()
containsCharacter = new RegExp(charactersRegexString)

module.exports.containsEntity = containsEntity
module.exports.containsCharacter = containsCharacter 