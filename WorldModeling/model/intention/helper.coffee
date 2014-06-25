entities = require('./../entities/environment').getAllEntityNames()

entitiesRegexString = "(#{entities.join('|')})".toLowerCase()
containsEntity = new RegExp(entitiesRegexString)

module.exports.containsEntity = containsEntity