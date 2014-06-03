q = require 'Q'
Character = require '../character'

class David extends Character
    constructor: ->
        super
            name : "david"
            location  : { x: 15, y: 20 }

module.exports.new = -> new David()