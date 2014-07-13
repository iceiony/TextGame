assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Interpreting dialogue in environment',->

    it('Greeting the chief should give a response',(done)->
        intention.interpretAsync('Hello chief')
        .then((intentions)->
            environment.reactAsync(intentions.shift())
        )
        .done((results)->
            result = results.shift()
            assert.strictEqual("Wildcard : Hello Chief.",result.text)
            assert.strictEqual("Chief : Hello Wildcard.",result.chain[0].text)
            done())
    )

    it('Asking the chief about the case (entity) should give a response',(done)->
        intention.interpretAsync('tell me about the body chief')
        .then((intentions)->
            environment.reactAsync(intentions.shift())
        )
        .then((results)-> # 0 - hidden output swallowed by story  
            result = results.shift()
            assert.strictEqual(result.text,"Wildcard : Tell me about the body Chief." )
            assert.notEqual(result.chain[0].text.indexOf("Chief : Middle aged man , found in the middle of nowhere , half naked.\n"), -1 , result.chain[0].text)
            assert.notEqual(result.chain[0].text.indexOf("        We don't know how the body got here or the cause of death."), -1 , result.chain[0].text)

            intention.interpretAsync('tell me more')
        )
        .then((intentions)->
            environment.reactAsync(intentions.shift())
        )
        .then((results)->
            result = results.shift()
            assert.notEqual(result.chain[0].text.indexOf("Chief : He probably died last night."),-1, result.chain[0].text);

            intention.interpretAsync('anything else?')
        )
        .then((intentions)->
            environment.reactAsync(intentions.shift())
        )
        .done((results)->
            result = results.shift()
            assert.strictEqual(result.chain[0].text ,"Chief : There isn't anything more I can tell you about it.");
            done())
    )


)