q = require 'Q'
Character = require '../character'

class Chief extends Character
    constructor: ->
        super 
            name : "chief"
            location  : { x: 20, y: 10 }

module.exports.new = -> new Chief()