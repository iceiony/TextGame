q = require 'Q'
Character = require '../character'

class Anne extends Character
    constructor: ->
        super
            name : "anne"
            location  : { x: 15, y: 20 }

module.exports.new = -> new Anne()