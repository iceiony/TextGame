q = require 'Q'
events = require 'events'
CommonSense = require './CommonSense'

Chief = new events.EventEmitter()
chiefsCommonSense = new CommonSense(Chief);

Chief.on('message', (message)->
    chiefsCommonSense.interpret(message)
)

Chief.on('greeted', ->
    #todo: respond to greetings
    Chief.emit('say', "Uhm, Willy, we already said hello son. ")
#                """Chief : Detective! Stop it with the hello already ! """
)

module.exports = {
    tellAsync: (message) ->
        deferred = q.defer()
        
        Chief.on('say', (dialog)->
            deferred.resolve("Chief : " + dialog)
        )
        
        Chief.emit('message', message)
        
        return deferred.promise;
}