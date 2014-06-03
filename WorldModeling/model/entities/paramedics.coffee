Entity = require '../entity'

class Paramedics extends Entity
    constructor : ->
        super
            name : "paramedics"
            location : { x: 15, y: 20 }
            composing : [
                @anne = require('./anne').new()
                @david = require('./david').new()
            ]

module.exports.new = -> new Paramedics()