class Entity
    constructor:(options)->
        @composing = []
        @aliases = []
        for property,value of options
            @[property] = value
        
    referredAs : -> 
        "the "+ @name
            
    getLocation: ->
        @location
        
    isNear: (entity)->
        entityLocation = entity.getLocation()
        return @location.x == entityLocation.x && @location.y = entityLocation.y;

    react : (stimulus)->
        componentReactions = []
        for component in @composing
            reaction = component.react(stimulus)
            if reaction then componentReactions.push(reaction)
        return componentReactions
        
        
module.exports = Entity