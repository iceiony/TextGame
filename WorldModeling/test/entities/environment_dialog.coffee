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

    it('Asking the chief about the body (entity) should give a response',(done)->
        intention.interpretAsync('tell me about the body chief')
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .then((result)-> # 0 - hidden output swallowed by story  
            assert.strictEqual(result.text,"Wildcard : Tell me about the body Chief." );
            assert.strictEqual(result.chain[0].text ,"Chief : Middle aged man , found in the middle of nowhere , half naked.\n We don't know how the body got here and the cause of death.");
            
            intention.interpretAsync('tell me more')
        )
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .then((result)->
            assert.strictEqual(result.chain[0].text ,"Chief : Ooh, he died last night.");
            
            intention.interpretAsync('tell me more')
        )
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .done((result)->
            assert.strictEqual(result.chain[0].text ,"Chief : There isn't anything more I can tell you about it.");
            done())
    )


)