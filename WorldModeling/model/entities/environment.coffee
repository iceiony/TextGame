q = require 'Q'
body = require('./body').new()
wildcard = require('./wildcard').new()

composingEntities = [wildcard,body]


module.exports.getObjectByName = (name)->
    for entity in composingEntities
        if entity.name == name 
            return entity 
    
module.exports.reactAsync = (intention)->
    deferred = q.defer()

    wildcard.executeAsync(intention)
    .then(deferred.resolve)
    
    deferred.promise;