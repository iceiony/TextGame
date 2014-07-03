Entity = require '../entity'

class Policemen extends Entity
    constructor : ->
        super
            name : "policemen"
            aliases : ["officers"]
            location : { x: 20, y: 10 }
            composing : [
                @chief = require('./chief').new()
                @henry = require('./henry').new()
                @stevey = require('./stevey').new()
            ]
            
    getLocation: ()->
        return @chief.getLocation()
            
    react: (stimulus)->
        componentReactions = super(stimulus)
        followCount = componentReactions.filter((officer)->
            officer.reason == 'follow'
        )
        if(followCount.length == 3 )
            result = componentReactions[0]
            result.character = @name
            result.text = "The officers follow him."
            return result
        else
            return componentReactions
            
        

module.exports.new = -> new Policemen()