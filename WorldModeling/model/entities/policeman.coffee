Entity = require '../entity'

class Policeman extends Entity
    constructor : ->
        super
            name : "policeman"
            aliases : ["officers"]
            location : { x: 20, y: 10 }
            composing : [
                @chief = require('./chief').new()
                @henry = require('./henry').new()
                @stevey = require('./stevey').new()
            ]
        

module.exports.new = -> new Policeman()