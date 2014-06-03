Entity = require '../entity'

class Tractor extends Entity
    constructor : ->
        super
            name : "tractor"
            location : { x: 3, y: 8 }

module.exports.new = -> new Tractor()