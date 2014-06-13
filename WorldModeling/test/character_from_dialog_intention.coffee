assert = require 'assert'
intention = require '../model/intention'


describe("Extracting character of interest from dialog", ->
    dialog = [
        { input: "what is your name?", entity: "implicit", subject :"you", attribute:"name"  }
        { input:"how old are you Mark?", entity: "mark" , subject:"you"}
        { input:"how old are you Mark", entity: "mark" , subject:"you"}
        { input:"Mark, how old are you?", entity: "mark" , subject:"you"}
        { input:"Mark how old are you", entity: "mark" , subject:"you"}
        { input:"can you tell me about the body Henry ?", entity: "henry" , subject :"body" }
        { input:"can you tell me about the body Henry", entity: "henry" , subject :"body" }
        { input:"tell me about the case chief", entity : "chief", subject :"case" }
        { input:"what do you think chief", entity : "chief", subject :"you", attribute:"think" }
        
    ]

    dialog.forEach((testCase)->
        it(testCase.input, (done)->
            intention.interpretAsync(testCase.input)
            .done((result)->
                assert.strictEqual(result.type, 'dialog', "For input : #{result.input}")
                assert.strictEqual(result.entity,testCase.entity)
                if testCase.subject
                    assert.strictEqual(result.subject,testCase.subject)
                done()
            )
        )
    )
)   