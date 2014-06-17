assert = require 'assert'
environment = require '../../model/entities/environment'

describe('Determining the implicit character for dialog depending on location',->
    dialogMock =undefined 
    beforeEach(->
        environment.reset()
        dialogMock =
            input: "how are you"
            type : 'dialog'
            entity : 'implicit'
            subject : 'you'
            attribute : 'are'
            isQuestion : true
    )
        
    it('For initial location it should be the chief',(done)->
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
    
    it('For paramedics it should be Anne',(done)->
        moveMock =
            type: 'movement'
            entity: 'paramedics'
        environment.reactAsync(moveMock)
        .then( (reaction)->
            environment.reactAsync(dialogMock)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual("Wildcard : How are you ?", result.text)
            assert.notEqual(result.chain[0].text.indexOf('Anne'), -1, "Anne should have answered : '#{result.chain[0].text}'" )
        )
        .done(->
            done()
        )
    )
    
    it('For next to farmer it should be the farmer',(done)->
        moveMock =
            type: 'movement'
            entity: 'farmer'
        environment.reactAsync(moveMock)
        .then( (reaction)->
            environment.reactAsync(dialogMock)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual("Wildcard : How are you ?", result.text)
            assert.notEqual(result.chain[0].text.indexOf('The farmer'), -1, "The Farmer should have answered : '#{result.chain[0].text}'" )
        )
        .done(->
            done()
        )
    )
    
    it('For next to the body it should be the chief',(done)->
        moveMock =
            type: 'movement'
            entity: 'body'
        environment.reactAsync(moveMock)
        .then( (reaction)->
            environment.reactAsync(dialogMock)
        )
        .then((results)->
            result = results.shift()
            assert.strictEqual("Wildcard : How are you ?", result.text)
            assert.notEqual(result.chain[0].text.indexOf('Chief'), -1, "The Chief should have answered : '#{result.chain[0].text}'" )
        )
        .done(->
            done()
        )
    )
)