assert = require 'assert'
environment = require '../../model/entities/environment'

describe('Determining the implicit character for dialog depending on location',->
    dialogMock = 
        input: "how are you"
        type : 'dialog'
        entity : 'implicit'
        subject : 'you'
        attribute : 'are'
        isQuestion : true
    
    
    it('For initial location it should be the chief',(done)->
        environment.reset()
        environment.reactAsync(dialogMock)
        .then((results)->
            result = results.shift()
            assert.strictEqual("Wildcard : How are you ?",result.text)
            assert.notEqual(result.chain[0].text.indexOf('Chief'), -1 , 'Chief should have answered')
        )
        .done(->
            done()
        )
    )
)