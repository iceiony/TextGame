class Entity
    constructor:(options)->
        for property,value of options
            @[property] = value

    referredAs : -> 
        "the "+ @name
            
    getLocation: ->
        @location
    
module.exports = Entity