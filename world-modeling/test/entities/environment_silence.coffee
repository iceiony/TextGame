assert = require 'assert'
environment = require '../../model/entities/environment'


describe('Reacting to intentions that are simply empty input (or silence)',->
    beforeEach(->
        environment.reset()
    )
    mockedIntention = {
        input : ""
        type : "silence"
    }
    
    it('should react by wildcard not doing anything',(done)->
      environment.reactAsync(mockedIntention)
      .then((results)->
        result = results.shift()
        assert.strictEqual(result.text, "Wildcard does nothing.")
      )
      .done((result,error)->
        done(error)
      )
    )
)