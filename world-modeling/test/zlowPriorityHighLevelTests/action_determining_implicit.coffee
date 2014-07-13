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
            environment.reactAsync(intent.shift())
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual("movement",result.type)

            intention.interpretAsync("turn it over")
        )
        .then((intentions)->
            intent = intentions.shift()
            assert.strictEqual("action",intent.type)
            assert.strictEqual("implicit",intent.entity)

            environment.reactAsync(intent)
        )
        .then((results)->
            result = results.shift()
            intention = result.intention

            assert.strictEqual("body",intention.entity, "intention should be implicitly set to body")
        )
        .done((result,error)->
            done(error)

        )
    )
)