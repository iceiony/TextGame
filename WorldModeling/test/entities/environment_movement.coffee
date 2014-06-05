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
            assert.strictEqual("Wildcard walks to the body.",result.text);
            
            assert.strictEqual("Chief walks to the body.",result.chain[0].text);
            assert.strictEqual("follow",result.chain[0].reason);

            assert.strictEqual("Henry walks to the body.",result.chain[1].text);
            assert.strictEqual("Stevey walks to the body.",result.chain[2].text);
            
            assert.strictEqual(result.chain.length , 3 , 'Only the policeman should follow wildcard.');
            done())
    )
)