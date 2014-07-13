assert = require 'assert'
intention = require '../model/intention'

describe('Extracting entity or direction of interest from observation', ->
    observations = [
        { input: "look around", direction: "around"}
        { input: "look at the body", entity: "body" }
        { input: "examine environment", entity: "environment" }
        { input: "check fist" , entity: "fist"}
    ]

    observations.forEach((observation)->
        it(observation.input, (done)->
            intention.interpretAsync(observation.input)
            .then((intentions)->
                result = intentions.shift()
                assert.strictEqual('observation',result.type,"For input : #{result.input}")
                assert.strictEqual(observation.direction,result.direction ,"For input : #{result.input}")
                if observation.entity 
                    assert.strictEqual(observation.entity, result.entity, "For input : #{result.input} ")
            )
            .done((res,err)->
                done(err)
            )
        )
    )
)