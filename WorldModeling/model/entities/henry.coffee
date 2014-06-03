q = require 'Q'
Character = require '../character'

class Henry extends Character
    constructor: ->
        super 
            name : "henry"
            location  : { x: 20, y: 10 }

module.exports.new = -> new Henry()