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

    it('Asking the chief about the case (entity) should give a response',(done)->
        intention.interpretAsync('tell me about the body chief')
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .then((result)-> # 0 - hidden output swallowed by story  
            assert.strictEqual(result.text,"Wildcard : Tell me about the body Chief." )
            assert.notEqual(result.chain[0].text.indexOf("Chief : Middle aged man , found in the middle of nowhere , half naked.\n"), -1 , result.chain[0].text)
            assert.notEqual(result.chain[0].text.indexOf("        We don't know how the body got here and the cause of death."), -1 , result.chain[0].text)

            intention.interpretAsync('tell me more')
        )
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .then((result)->
            assert.notEqual(result.chain[0].text.indexOf("Chief : He probably died last night."),-1, result.chain[0].text);

            intention.interpretAsync('anything else?')
        )
        .then((interpretation)->
            environment.reactAsync(interpretation)
        )
        .done((result)->
            assert.strictEqual(result.chain[0].text ,"Chief : There isn't anything more I can tell you about it.");
            done())
    )


)