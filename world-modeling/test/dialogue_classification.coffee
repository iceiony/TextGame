assert = require 'assert'
intention = require '../model/intention'

describe('Classifying dialogue intentions correctly', ->
    describe('by input structure that is a question', ->
        questions = [
            {input: "what is your name", subject: "you", attribute: "name"}
            {input: "are you ok ?", subject: "you"  }
            {input: "how are you?", subject: "you" }
            {input: "how do you do", subject: "you" }
            {input: "what is the case", subject: "case"}
            {input: "how come ?"}
            {input: "where is the body?", subject: "body"}
            {input: "ask about the body", subject: "body"}
            {input: "did you kill him", subject: "you", attribute: "kill"}
            {input: "tell me what you saw", subject: "you", attribute: "saw"}
            {input: "can you help", subject: "you", attribute: "help"}
            {input: "how are you", subject: "you", attribute: "are"}
            {input: "are you a faggot", subject: "you", attribute: "faggot"}
            {input: "body ?", subject: "body"}
            {input: "huh ?"}
        ]

        questions.forEach((question)->
            it(question.input, (done)->
                intention.interpretAsync(question.input)
                .done((intentions, err)->
                    res = intentions.shift()
                    if (err) then throw err
                    assert.strictEqual(res.type, 'dialogue', "For input #{res.input}")

                    assert.strictEqual(res.subtype, "question", "Not classified as question #{res.input}")
                    assert.strictEqual(res.entity, 'implicit')

                    if question.subject
                        assert.strictEqual(res.subject, question.subject, "For input #{res.input}")
                    if question.attribute
                        assert.strictEqual(res.attribute, question.attribute, "For input #{res.input}")

                    done()
                )
            ))
    )

    describe('by input structure that a statement with a personal pronoun', ->
        questions = [
            {input: "give me the keys", subject: "keys" }
            {input: "I don't think so"}
            {input: "I don't know"}
            {input: "yes"}
            {input: "may be wrong"}
            {input: "banana"}

        ]

        questions.forEach((question)->
            it(question.input, (done)->
                intention.interpretAsync(question.input)
                .then((intentions)->
                    res = intentions.shift()
                    assert.strictEqual(res.type, 'dialogue', "For input #{res.input}")
                    assert.strictEqual(res.entity, 'implicit')

                    if question.subject
                        assert.strictEqual(res.subject, question.subject, "For input #{res.input}")
                    if question.attribute
                        assert.strictEqual(res.attribute, question.attribute, "For input #{res.input}")
                )
                .done(->
                    done()
                )
            )
        )
    )

    describe('by exclamations', ->
        exclamation = [
            "hi"
            "hello"
            'howdy'
            'greetings'
            'oi!'
            'attention!'
            'hahaha'
        ]
        exclamation.forEach((input)->
            it(input, (done)->
                intention.interpretAsync(input)
                .then((intentions)->
                    res = intentions.shift()
                    assert.strictEqual(res.type, 'dialogue', "For input #{res.input}")
                    assert.strictEqual(res.subtype, 'exclamation', "Not classified as exclamation #{res.input}")
                    
                )
                .done((res,err)->
                    done(err)
                )
            ))
    )



    describe('Setting implicit character when the last text output had a question from a character', ->
        intentionInput = "i don't know"
        lastTextOutputs = ["""
        Chief : I wonder...
        Henry : We don't know.
                What do you think ? 
        """
        """
        Chief : I wonder...
        Henry : What do you think ? 
        """
        """
        Chief : I wonder...
        Henry : What do you think ? 
        Henry asked the detective . 
        """
        ]
        
        lastTextOutputs.forEach((lastTextOutput)->
            it('Should set the implicit character to the one that last asked the question',(done)->
                intention.interpretAsync(intentionInput,lastTextOutput)
                .then((intentions)->
                    interpretation = intentions.shift()
                    assert.strictEqual(interpretation.type,"dialogue")
                    assert.strictEqual(interpretation.entity,"henry","For last text \n#{lastTextOutput}")
                )
                .done((result,error)->
                    done(error);
                )
            )
        )
        
    )
)