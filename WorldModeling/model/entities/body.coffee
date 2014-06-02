class Body 
    constructor : ->
        @name = "body"
    referredAs : -> "the body"
    getLocation :->
        x:30
        y:20

module.exports.new = ->
    new Body()