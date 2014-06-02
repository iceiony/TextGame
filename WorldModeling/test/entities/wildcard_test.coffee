describe('Wildcard executing a move instruction for a given direction', ->
    assert = require 'assert'
    wildcard = require('../../model/entities/wildcard').new()
    
    it('Should move next to the body', (done)->
        initialLocation = wildcard.getLocation()
        intention =
            type: 'movement'
            object: 'body'

        wildcard.executeAsync(intention)
        .then((result)->
            newLocation = wildcard.getLocation()
            assert.notDeepEqual(initialLocation, newLocation)
            assert.equal("Wildcard walks to the body.", result)
            wildcard.executeAsync(intention)
        ).then((result)->
            assert.strictEqual("Wildcard is already next to the body.", result)
            done()
        )
    )
)