assert = require 'assert'
intention = require '../../model/intention'

describe("When handling input which is multiple sentences or phrases",->
    
    it('Should split the input into multiple intentions and react to it',(done)->
        input = "I'm doing fine,how about you ?"
        
        intention.interpretAsync(input)
        .then((intentions)->
            assert.equal(intentions.length,2,"Should have 2 intentions for input : #{input}");

            first = intentions.shift()
            assert.equal(first.type, 'dialogue')
            assert.equal(first.subtype, 'statement')
            
            second = intentions.shift()
            assert.equal(second.type, 'dialogue')
            assert.equal(second.subtype, 'question')
        )
        .done((res,err)->
            done(err)
        )
    )
    
)