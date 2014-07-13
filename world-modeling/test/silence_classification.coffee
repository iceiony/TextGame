assert = require 'assert'
intention = require '../model/intention'

describe('Silence - No action classification for empty strings' , ->

        it('should be classified as "silence"', (done)->
            intention.interpretAsync('')
            .then((result)->
                result = result.shift()
                assert.strictEqual(result.type,'silence')
            )
            .done((result,error)->
                done(error)
            )
        )
)