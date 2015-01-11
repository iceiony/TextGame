q = require 'q'
Character = require '../character'

class Mark extends Character
    constructor: ->
        super 
            name : "farmer"
            aliases : ["edd" ,"mark", "ranch","witness"]
            location  : { x: 3, y: 8 }
        @knowledge = 
            'happened' : {known:["I don't know. I just found a dead guy"] }
            'you' : {
                'are': ['fine']
            }
            
    referredAs: ->
        "the farmer"

module.exports.new = -> new Mark()