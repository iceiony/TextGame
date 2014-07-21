assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe('Acting on an implicit entity after moving to it',->
    beforeEach(->
        environment.reset()
    )

    it('should replace the implicit entity with the correct one' , (done)->
        intention.interpretAsync("walk to body")
        .then((intent)->
            environment.reactAsync(intent)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual(result.type,"movement")

            intention.interpretAsync("turn it over")
        )
        .then((intent)->
            intent = intent.shift()
            assert.strictEqual(intent.type,"action")
            assert.strictEqual(intent.entity,"implicit")

            environment.reactAsync(intent)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual(result.intention.entity,"body", "implicit intention should be set to body")
        )
        .done((result,error)->
            done(error)

        )
    )
)