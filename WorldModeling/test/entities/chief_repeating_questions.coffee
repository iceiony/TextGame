assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'
sinon = require 'sinon'


describe('Asking re-occurring questions about objects and entities', ->

    it('Asking the chief about the case (concept) should give a response', (done)->
        intent = undefined
        
        intention.interpretAsync('tell me about the case chief')
        .then((interpretation)->
            intent = interpretation
            environment.reactAsync(intent)
        )
        .then((result)-># 0 - hidden reaction swallowed by the game
            assert.strictEqual(result.text, "Wildcard : Tell me about the case Chief.")
            assert.strictEqual(result.chain[0].text, "Chief : We have a body and need to find out what happened.")
            environment.reactAsync(intent)
        )
        .then((result)-># 1st reaction
#            assert.strictEqual(result.chain[0].text, "Chief : Like I said, we have a body and we don't know where it came from.")
            assert.strictEqual(result.chain[0].text, "Chief : There isn't anything more I can tell you about it.")
            environment.reactAsync(intent)
        )
        .then((result)->#2nd reaction -concerned
            assert.strictEqual(result.chain[0].text, "Chief : Listen, I don't know more about the case than what I told you already")
            environment.reactAsync(intent)
        )
        .then((result)->#3rd reaction -annoyed 
            assert.strictEqual(result.chain[0].text, "Chief : Stop it with the darn case already !")
            environment.reactAsync(intent)
        )
        .then((result)->#4th reaction - threaten
            assert.strictEqual(result.chain[0].text, "Chief : If you ask me about the case one more time I'll dismiss you !")
            environment.reactAsync(intent)
        )
        .then((result)->#5th reaction  -silent treatment
            assert.strictEqual(result.chain[0].text, "Chief ignores the request.")
            environment.reactAsync(intent)
        )
        .done((result)-> #6 reaction - dismissed from the case 
            assert.strictEqual(result.chain[0].text, "Chief: That's it Wildcard , you're off the case. Go home and take your medication and have a good rest.")
            done()
        )
    )

    it('Asking the chief about a known entity but after at least 5 minutes', (done)->
        clock = sinon.useFakeTimers(0, "setTimeout", "clearTimeout", "setInterval", "clearInterval", "Date")
        environment.reset()
        intent = undefined

        intention.interpretAsync('tell me about the case chief')
        .then((interpretation)->
            intent = interpretation
            environment.reactAsync(intent)
        )
        .then((result)->#0 - knowledge share here
            environment.reactAsync(intent)
        )
        .done((result)->#1 - no more knowledge here
            assert.strictEqual(result.chain[0].text, "Chief : There isn't anything more I can tell you about it.")
            clock.tick(5 * 60 * 1000)

            setTimeout(->
                console.log 'assert set to happen'
                environment.reactAsync(intent)
                .then((result)-> #2 - reminder here 
                    try
                        assert.notEqual(result.chain[0].text.indexOf("Chief : Like I said."), -1, result.chain[0].text)
                        assert.notEqual(result.chain[0].text.indexOf("We have a body and need to find out what happened."),-1, result.chain[0].text)
                    catch error
                        err = error
                    finally
                        clock.restore()
                        done(err)
                )
            , 1000)
            clock.tick(1000)
        )
    )

    it('Asking the chief about an unrelated thing repeatedly', (done)->
        intent = undefined 
        intention.interpretAsync('tell me about the stars chief')
        .then((interpretation)->
            intent = interpretation
            environment.reactAsync(intent)
        )
        .then((result)->
            assert.strictEqual(result.text, 'Wildcard : Tell me about the stars Chief.')
            assert.strictEqual(result.chain[0].text, "Chief : What does that have to do with anything ? ")
            environment.reactAsync(intent)
        )
        .then((result)->
            assert.strictEqual(result.chain[0].text, "Chief : What is it with you and the stars ?  ")
            environment.reactAsync(intent)
        )
        .done((result)->
            assert.strictEqual(result.chain[0].text, "Chief : No !  ")
            done()
        )
    )

)
