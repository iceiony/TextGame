q = require 'Q'
Character = require '../character'

class Stevey extends Character
    constructor: ->
        super 
            name : "stevey"
            location  : { x: 20, y: 10 }

module.exports.new = -> new Stevey()