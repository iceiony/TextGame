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
        
        
module.exports = Entity