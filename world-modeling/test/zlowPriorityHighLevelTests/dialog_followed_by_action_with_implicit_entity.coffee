assert = require 'assert'
intention = require '../../model/intention'
environment = require '../../model/entities/environment'

describe("Dialogue followed by action with implicit entity",->
    beforeEach(->
        environment.reset()
    )
    
    it("Should replace the implicit entity in action with the SUBJECT of the preceding dialogue",(done)->
        intention.interpretAsync("tell me about mark")
        .then((res)->
            res = res.shift()
            assert.strictEqual(res.subject , "mark", "Subject for :#{res.input}")
            environment.reactAsync(res)
        )
        .then((res)->
            intention.interpretAsync("lets talk to him")
        )
        .then((res)->
            res = res.shift()
            assert.strictEqual(res.entity,"implicit", "Entity for :#{res.input}")
            environment.reactAsync(res)
        )
        .then((res)->
            assert.strictEqual(res[0].intention.entity,'mark',"Entity for #{res[0].intention.input}")            
        )
        .done((res,err)->
            done(err)
        )
    )
    
    it("Should replace the implicit entity in action with the ATTRIBUTE of the preceding dialogue",(done)->
        intention.interpretAsync("what do you know about mark?")
        .then((res)->
            res = res.shift()
            assert.strictEqual(res.subject , "you", "Subject for :#{res.input}")
            assert.strictEqual(res.attribute , "mark", "Attribute for :#{res.input}")
            environment.reactAsync(res)
        )
        .then((res)->
            intention.interpretAsync("lets talk to him")
        )
        .then((res)->
            res = res.shift()
            assert.strictEqual(res.entity,"implicit", "Entity for :#{res.input}")
            environment.reactAsync(res)
        )
        .then((res)->
            assert.strictEqual(res[0].intention.entity,'mark',"Entity for #{res[0].intention.input}")            
        )
        .done((res,err)->
            done(err)
        )
    )
)