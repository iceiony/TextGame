Entity = require '../entity'

class Body extends Entity
    constructor : ->
        super
            name : "body"
            location : { x: 30 , y:25 }
            
module.exports.new = ->
    new Body()