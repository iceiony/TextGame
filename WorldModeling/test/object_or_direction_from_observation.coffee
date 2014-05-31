assert = require 'assert'
intention = require '../model/intention'

describe('Extracting object or direction of interest from observation', ->
    observations = [
        { input: "look around", direction: "around"}
        { input: "look at the body", object: "body" }
        { input: "examine environment", object: "environment" }
    ]

    observations.forEach((observation)->
        it(observation.input, (done)->
            intention.interpretAsync(observation.input)
            .done((result)->
                assert.strictEqual(result.type,'observation',"For input : #{result.input}")
                assert.strictEqual(result.direction,observation.direction)
                assert.strictEqual(result.object,observation.object)
                done()
            )
        )
    )
)