assert = require 'assert'
intention = require '../model/intention'

describe('Classifying plain action intentions correctly', ->
    describe('by input structure', ->
        actions = [
            {input : "turn over body" , verb:"turn",entity:"body"}
            {input : "drive tractor", verb:"drive",entity:"tractor"}
            {input : "take match", verb:"take",entity:"match"}
            {input : "punch farmer", verb:"punch",entity:"farmer"}
            {input : "talk to the farmer", verb:"talk",entity:"farmer"}
            {input : "punch the sky", verb:"punch",entity:"sky"}]
        
        actions.forEach((action)->  
            it(action.input, (done)->  
                intention.interpretAsync(action.input) 
                .then((res)->
                    assert.strictEqual(res.type, 'action' , "For input #{res.input}")
                    assert.strictEqual(res.verb, action.verb, "For input #{res.input}")
                    assert.strictEqual(res.entity, action.entity, "For input #{res.input}")
                )
                .done((res,err)->
                    done(err)
                )
            ))
    )
     
) 