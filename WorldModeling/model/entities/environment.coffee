q = require 'Q'

wildcard = require('./wildcard').new()
composingEntities = [ 
    wildcard
    body = require('./body').new()
    mark = require('./mark').new()
    tractor = require('./tractor').new()
    chief = require('./chief').new()
    henry = require('./henry').new()
    stevey = require('./stevey').new()
    anne = require('./anne').new()
    david = require('./david').new()
]

module.exports.getObjectByName = (name)->
    for entity in composingEntities
        if entity.name == name
            return entity

module.exports.reactAsync = (intention)->
    deferred = q.defer()

    wildcard.executeAsync(intention)
    .then(deferred.resolve)

    deferred.promise;