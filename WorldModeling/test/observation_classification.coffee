assert = require 'assert'
intention = require '../model/intention'

describe('Classifying observation intentions correctly', ->
    describe('by input actions that are to do the act of observing', ->
        questions = [
            "look around"
            "examine environment"
            "check body"
            "inspect tractor"
        ]

        questions.forEach((input)->
            it(input, (done)->
                intention.interpretAsync(input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'observation', "For input : #{input}")
                    done()
                )
            ))
    )
)