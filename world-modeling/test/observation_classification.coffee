assert = require 'assert'
intention = require '../model/intention'

describe('Classifying observation intentions correctly', ->
    describe('by input actions that are to do the act of observing', ->
        questions = [
            "look around"
            "examine environment"
            "check body"
            "inspect tractor"
            "look more"
            "search more"
        ]

        questions.forEach((input)->
            it(input, (done)->
                intention.interpretAsync(input)
                .then((res)->
                    res = res.shift()
                    assert.strictEqual(res.type, 'observation', "For input : #{res.input}")
                )
                .done((res,err)->
                    done(err);
                )
            ))
    )
)