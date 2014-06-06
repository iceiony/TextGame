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

    react : (stimuli)->
        componentReactions = []
        for component in @composing
            reaction = component.react(stimuli)
            if reaction then componentReactions.push(reaction)
        return componentReactions
        
        
module.exports = Entity