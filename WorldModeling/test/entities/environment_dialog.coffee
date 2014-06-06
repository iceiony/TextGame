assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Interpreting dialog in environment',->

    it('Greeting the chief should give a response',(done)->
        input = 'Hello chief'
        intention.interpretAsync(input)
        .then((interpretation)->
            environment.reactAsync(interpretation))
        .done((result)->
            assert.strictEqual("Wildcard: Hello Chief.",result.text)
            assert.strictEqual("Chief: Hello Wildcard.",result.chain[0].text)
            done())
    )
)