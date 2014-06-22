assert = require 'assert'
intention = require '../model/intention'

describe('Classifying plain action intentions correctly', ->
    describe('by input structure that is a question', ->
        actions = [
            "turn over body"
            "drive tractor"
            "take match"
            "punch farmer"
            "talk to the farmer"
        ]

        actions.forEach((input)->
            it(input, (done)->
                intention.interpretAsync(input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'action', "For input #{res.input}")
                    done()
                )
            ))
    )
)