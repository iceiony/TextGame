assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Asking a question to a character that is not nearby', ->
    environment.reset();

    it('Asking the farmer how he is', (done)->
        input = 'Ask the farmer how he is'
        intention.interpretAsync(input)
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual("Wildcard walks to the farmer.", result.text)
            assert.strictEqual("The officers follow him.", result.chain[0].text)
            
            result = results.shift()
            assert.strictEqual("Wildcard : How are you ?",result.text);
            assert.strictEqual("The farmer : I am fine.",result.chain[0].text);
        ).done(->
            done()
        )
    )
)

