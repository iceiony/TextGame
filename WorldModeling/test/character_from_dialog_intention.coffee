assert = require 'assert'
intention = require '../model/intention'


describe("Extracting character of interest from dialog", ->
    dialog = [
        { input: "what is your name?", target: "implicit" }
        { input:"how old are you Mark?", target: "mark" }
        { input:"how old are you Mark", target: "mark" }
        { input:"Mark, how old are you?", target: "mark" }
        { input:"Mark how old are you", target: "mark" }
        { input:"can you tell me about the body Henry ?", target: "henry" }
        { input:"can you tell me about the body Henry", target: "henry" }
    ]

    dialog.forEach((testCase)->
        it(testCase.input, (done)->
            intention.interpretAsync(testCase.input)
            .done((result)->
                assert.strictEqual(result.type, 'dialog', "For input : #{result.input}")
                assert.strictEqual(result.target,testCase.target)
                done()
            )
        )
    )
)   