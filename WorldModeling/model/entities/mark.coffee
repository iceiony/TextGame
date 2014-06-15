q = require 'Q'
Character = require '../character'

class Mark extends Character
    constructor: ->
        super 
            name : "mark"
            aliases : ["farmer","edd"]
            location  : { x: 3, y: 8 }
        @knowledge = 
            'you' : {
                'are': ['fine']
            }
            
    referredAs: ->
        "the farmer"

module.exports.new = -> new Mark()