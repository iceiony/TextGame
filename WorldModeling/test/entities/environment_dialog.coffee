assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Interpreting dialog in environment',->

    it('Greeting the chief should give a response',(done)->
        intention.interpretAsync('Hello chief')
        .then((interpretation)->
            environment.reactAsync(interpretation))
        .done((result)->
            assert.strictEqual("Wildcard : Hello Chief.",result.text)
            assert.strictEqual("Chief : Hello Wildcard.",result.chain[0].text)
            done())
    )
    
    
    it('Asking the chief about the case should give a response',(done)->
        intention.interpretAsync('tell me about the case chief')
        .then((interpretation)->
            environment.reactAsync(interpretation))
        .done((result)->
            assert.strictEqual(result.text,"Wildcard : Tell me about the case Chief." );
            assert.strictEqual(result.chain[0].text,"Chief : Like I said, we have a body and we don't know where it came from." );
            done())
    )
    
    
    it('Asking the chief about the body should give a response',(done)->
        intention.interpretAsync('tell me about the body chief')
        .then((interpretation)->
            environment.reactAsync(interpretation))
        .done((result)->
            assert.strictEqual(result.text,"Wildcard : Tell me about the body Chief." );
            assert.strictEqual(result.chain[0].text ,"Chief : There isn't anything more I can tell you about it.");
            done())
    )
    
    it('Asking the chief about an unrelated entity repeatedly',(done)->
        intention.interpretAsync('tell me about the stars chief')
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .then((result)->
            assert.strictEqual(result.text,'Wildcard : Tell me about the stars Chief.');
            assert.strictEqual(result.chain[0].text,"Chief : What does that have to do with anything ? ");
            
            intention.interpretAsync('tell me about the stars chief')
        )
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .then((result)->
            assert.strictEqual(result.text,'Wildcard : Tell me about the stars Chief.');
            assert.strictEqual(result.chain[0].text,"Chief : What is it with you and the stars ?  ");

            intention.interpretAsync('tell me about the stars chief')
        )
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .done((result)->
            assert.strictEqual(result.text,'Wildcard : Tell me about the stars Chief.');
            assert.strictEqual(result.chain[0].text,"Chief : No !  ");
            
            done()
        )
    )
)