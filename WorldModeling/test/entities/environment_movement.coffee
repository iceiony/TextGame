assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Interpreting movement in environment',->
    
    it('moving to the body',(done)->
        input = 'go to body'
        intention.interpretAsync(input)
        .then((interpretation)->
            environment.reactAsync(interpretation))
        .done((result)->
            assert.strictEqual("Wildcard walks to the body.",result);
            done())
    )
)