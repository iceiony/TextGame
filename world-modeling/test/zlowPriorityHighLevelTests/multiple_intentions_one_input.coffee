assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Multiple intentions in one single input',->

    beforeEach(->
        environment.reset()
    )

    input = "I'm doing fine. How are you ?"
    it('Should have 2 intentions and 2 reactions for the single input',(done)->
        intention.interpretAsync(input)
        .then((interpretation)->
            assert.strictEqual(interpretation.length,2,"Interpretations found : #{interpretation}")
            
            environment.reactAsync(interpretation)
        )
        .then((reactions)->
            assert.strictEqual(reactions.length,2, "Reactions found : #{reactions}")
        )
        .done((res,err)->
            done(err)
        )
    )
)