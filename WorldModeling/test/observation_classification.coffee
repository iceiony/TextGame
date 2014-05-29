assert = require 'assert'
intention = require '../model/intention'

describe('Classifying dialog intentions correctly', ->
    describe('by input structure that is a question', ->
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