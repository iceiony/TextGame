assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Interpreting movement in environment',->
    beforeEach(->
        environment.reset()
    )
    
    it('moving to the body',(done)->
        input = 'go to body'
        intention.interpretAsync(input)
        .then((interpretation)->
            environment.reactAsync(interpretation))
        .done((results)->
            result = results.shift()
            assert.strictEqual("Wildcard walks to the body.",result.text)
            assert.strictEqual("The officers follow him.",result.chain[0].text)
            done())
    )
)