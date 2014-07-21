assert = require 'assert'
intention = require '../model/intention'


describe("Extracting character of interest from dialogue", ->
    dialogue = [
        { input: "what is your name?", entity: "implicit", subject :"you", attribute:"name"  }
        { input:"can you tell me what to do ?", entity : "implicit", subject :"you" , attribute:"do"}
        { input:"what should I do?", entity : "implicit", subject :"do" }
        { input:"how old are you Mark?", entity: "mark" , subject:"you"}
        { input:"how old are you Mark", entity: "mark" , subject:"you"}
        { input:"Mark, how old are you?", entity: "mark" , subject:"you"}
        { input:"Mark how old are you", entity: "mark" , subject:"you"}
        { input:"can you tell me about the body Henry ?", entity: "henry" , subject :"body" }
        { input:"can you tell me about the body Henry", entity: "henry" , subject :"body" }
        { input:"tell me about the case chief", entity : "chief", subject :"case" }
        { input:"what do you think chief", entity : "chief", subject :"you", attribute:"think" }
        { input:"what do you think henry", entity : "henry", subject :"you", attribute:"think" }
        { input:"ask the farmer how he is", entity : "farmer", subject :"you", attribute:"are"}
        { input:"chief, what do you make of this", entity : "chief", subject :"you", attribute:"implicit" }
    ]

    dialogue.forEach((testCase)->
        it(testCase.input, (done)->
            intention.interpretAsync(testCase.input)
            .done((results)->
                result = results.shift()
                assert.strictEqual(result.type, 'dialogue', "For input : #{result.input}")
                assert.strictEqual(result.entity,testCase.entity)
                if testCase.subject
                    assert.strictEqual(result.subject,testCase.subject, "For input : #{result.input}")
                if testCase.attribute
                    assert.strictEqual(result.attribute,testCase.attribute, "For input : #{result.input}")
                done()
            )
        )
    )
)   