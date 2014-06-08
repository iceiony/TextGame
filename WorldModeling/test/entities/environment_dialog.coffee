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
            assert.strictEqual("Wildcard : Hello Chief.",result.text)
            assert.strictEqual("Chief : Hello Wildcard.",result.chain[0].text)
            done())
    )
    
    
    it('Asking the chief about the case should give a response',(done)->
        input = 'tell me about the case chief'
        
        intention.interpretAsync(input)
        .then((interpretation)->
            environment.reactAsync(interpretation))
        .done((result)->
            assert.strictEqual(result.text,"Wildcard : Tell me about the case Chief." );
            assert.strictEqual(result.chain[0].text,"Chief : Like I said, we have a body and we don't know where it came from." );
            done())
    )
    
    
    it('Asking the chief about the body should give a response',(done)->
        input = 'tell me about the body chief'
        
        intention.interpretAsync(input)
        .then((interpretation)->
            console.log interpretation
            environment.reactAsync(interpretation))
        .done((result)->
            assert.strictEqual(result.text,"Wildcard : Tell me about the body Chief." );
            assert.strictEqual(result.chain[0].text ,"Chief : There isn't anything more I can tell you about it.");
            done())
    )
)