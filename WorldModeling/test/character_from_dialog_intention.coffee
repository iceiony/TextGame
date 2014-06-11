assert = require 'assert'
intention = require '../model/intention'


describe("Extracting character of interest from dialog", ->
    dialog = [
        { input: "what is your name?", object: "implicit", subject :"name"  }
        { input:"how old are you Mark?", object: "mark" }
        { input:"how old are you Mark", object: "mark" }
        { input:"Mark, how old are you?", object: "mark" }
        { input:"Mark how old are you", object: "mark" }
        { input:"can you tell me about the body Henry ?", object: "henry" , subject :"body" }
        { input:"can you tell me about the body Henry", object: "henry" , subject :"body" }
        { input:"tell me about the case chief", object : "chief", subject :"case" }
    ]

    dialog.forEach((testCase)->
        it(testCase.input, (done)->
            intention.interpretAsync(testCase.input)
            .done((result)->
                assert.strictEqual(result.type, 'dialog', "For input : #{result.input}")
                assert.strictEqual(result.object,testCase.object)
                if testCase.subject
                    assert.strictEqual(result.subject,testCase.subject)
                done()
            )
        )
    )
)   