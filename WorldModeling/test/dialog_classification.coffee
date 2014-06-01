assert = require 'assert'
intention = require '../model/intention'

describe('Classifying dialog intentions correctly', ->
    describe('by input structure that is a question', ->
        questions = [
            "what is your name"
            "are you ok ?"
            "how are you?"
            "how do you do"
            "what is the case"
            "how come ?"
            "where is the body?"
            "ask about the body"
            "can you help"
            "body ?"
            "huh ?"
        ]

        questions.forEach((input)->
            it(input, (done)->
                intention.interpretAsync(input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'dialog', "For input #{res.input}")
                    done()
                )
            ))
    )

    describe('by exclamations', ->
        exclamation = [
            "hi"
            "hello"
            'howdy'
            'greetings'
            'oi!'
            'attention!'
        ]
        exclamation.forEach((input)->
            it(input, (done)->
                intention.interpretAsync(input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'dialog', "For input #{res.input}")
                    done()
                )
            ))
    )
)