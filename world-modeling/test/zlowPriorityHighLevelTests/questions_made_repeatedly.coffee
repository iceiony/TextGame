assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'
sinon = require 'sinon'


describe('Asking re-occurring questions about objects and entities', ->
    beforeEach(->
        environment.reset()
    )
    
    it('Asking the chief about the case (concept) should give a response', (done)->
        intent = undefined
        
        intention.interpretAsync('tell me about the case chief')
        .then((interpretation)->
            intent = interpretation
            environment.reactAsync(intent)
        )
        .then((results)-># 0 - hidden reaction swallowed by the game
            result = results.shift()
            assert.strictEqual(result.text, "Wildcard : Tell me about the case Chief.")
            assert.strictEqual(result.chain[0].text, "Chief : We have a body and need to find out what happened.")
            environment.reactAsync(intent)
        )
        .then((results)-># 1st reaction
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : There isn't anything more I can tell you about it.")
            environment.reactAsync(intent)
        )
        .then((results)->#2nd reaction -concerned
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : Listen, I don't know more about the case than what I told you already")
            environment.reactAsync(intent)
        )
        .then((results)->#3rd reaction -annoyed 
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : Stop it with the darn case already !")
            environment.reactAsync(intent)
        )
        .then((results)->#4th reaction - threaten
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : If you ask me about the case one more time you'll be dismissed !")
            environment.reactAsync(intent)
        )
        .then((results)->#5th reaction  -silent treatment
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : ignores the request.")
            environment.reactAsync(intent)
        )
        .then((results)-> #6 reaction - dismissed from the case 
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : That's it Wildcard , you're off the case. Go home and take your medication and have a good rest.")
        )
        .done((res,err)->
            done(err) 
        )
    )

    it('Asking the chief about a known entity but after at least 5 minutes', (done)->
        intent = undefined
        clock = sinon.useFakeTimers(0, "setTimeout")

        intention.interpretAsync('tell me about the case chief')
        .then((interpretation)->
            intent = interpretation
            environment.reactAsync(intent)
        )
        .then((results)->#0 - knowledge share here
            environment.reactAsync(intent)
        )
        .done((results,err)->#1 - no more knowledge here
            try
                if err then throw err

                result = results.shift()
                assert.strictEqual(result.chain[0].text, "Chief : There isn't anything more I can tell you about it.")
                clock.tick(5 * 60 * 1000)
        
                setTimeout(->
                    environment.reactAsync(intent)
                    .then((results)-> #2 - reminder here 
                        result = results.shift()
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
            catch err
                clock.restore()
                done(err)
        )
    )

    it('Asking the chief about an unrelated thing repeatedly', (done)->
        intent = undefined 
        intention.interpretAsync('tell me about the stars chief')
        .then((interpretation)->
            intent = interpretation
            environment.reactAsync(intent)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual(result.text, 'Wildcard : Tell me about the stars Chief.')
            assert.strictEqual(result.chain[0].text, "Chief : What are you talking about ?")
            environment.reactAsync(intent)
        )        
        .then((results)->
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : What does that have to do with anything ?")
            environment.reactAsync(intent)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : What is it with you and the stars ?")
            environment.reactAsync(intent)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual(result.chain[0].text, "Chief : No !")
        )
        .done((res,err)->
            done(err)
        )
    )
    
    it('Asking the chief things about himself - verb attribute',(done)->
        intent = undefined 
        
        intention.interpretAsync('tell me what you think chief')
        .then((intent)->
            environment.reactAsync(intent)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual(result.text,"Wildcard : What do you think Chief ?")
            assert.strictEqual(result.chain[0].text, 'Chief : I think you should look at the body.')
        )
        .done((res,err)->
            done(err)
        )
    )
    
    it('Asking the chief things about himself - noun attribute',(done)->
        intent = undefined
        
        intention.interpretAsync('What is your age chief ?')
        .then((intent)->
            environment.reactAsync(intent)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual(result.text,"Wildcard : What is your age Chief ?")
            assert.strictEqual(result.chain[0].text, "Chief : My age is 57, boy.")
        )
        .done((res,err)->
            done(err)
        )
    )
   

)
