assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Observing an entity that is not nearby', ->
    beforeEach(->
        environment.reset()
    )

    it('Looking at the body', (done)->
        input = 'look at the body'
        intention.interpretAsync(input)
        .then((interpretation)->
            environment.reactAsync(interpretation.shift())
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual("Wildcard walks to the body.", result.text)
            assert.strictEqual("The officers follow him.", result.chain[0].text)
            assert.strictEqual("movement", result.intention.type , "should create its required intention")
            assert(result.intention.input , "should have a auto generated input")

            result = results.shift()
            assert.strictEqual("observation",result.intention.type, "should put the original dialog intention");
            assert.strictEqual(input.toLowerCase(), result.intention.input , "should have the original input")
        ).done(->
            done()
        )
    )
)

