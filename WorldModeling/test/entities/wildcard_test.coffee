describe('Wildcard executing a move instruction for a given direction', ->
    assert = require 'assert'
    wildcard = require('../../model/entities/wildcard').new()
    
    it('Should move next to the body', ->
        initialLocation = wildcard.getLocation()
        intention =
            type: 'movement'
            entity: 'body'

        result = wildcard.execute(intention)
        newLocation = wildcard.getLocation()
        assert.notDeepEqual(initialLocation, newLocation)
        assert.equal("Wildcard walks to the body.", result.text)
        
        result = wildcard.execute(intention)
        assert.strictEqual("Wildcard is already next to the body.", result.text)
    )
)