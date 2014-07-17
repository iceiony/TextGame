assert = require 'assert'
helper = require '../model/pos_helper'

describe('PosHelper - When splitting input that is multiple sentences',->
    it('Should split phrases separated by coma',(done)->
        result = helper.splitPhrase("i am doing fine , how about you ?") 
        assert.strictEqual(result.length,2)
        assert.strictEqual(result[0],"i am doing fine")
        assert.strictEqual(result[1],"how about you ?")
        done()
    )

    it('Should split phrases separated by stop',(done)->
        result = helper.splitPhrase("i am doing fine. how about you ?") 
        assert.strictEqual(result.length,2)
        assert.strictEqual(result[0],"i am doing fine")
        assert.strictEqual(result[1],"how about you ?")
        done()
    )
    it('Should not split enumeration',(done)->
        result = helper.splitPhrase("i want bananas , berries and chocolate")
        assert.strictEqual(result.length,1)
        assert.strictEqual(result[0],"i want bananas , berries and chocolate")
        done()
    )
    
    it('Should not split commas in non phrases like questions',(done)->
        result = helper.splitPhrase("mark, how old are you?")
        assert.strictEqual(result.length,1, "['#{result.join('\',\'')}']")
        assert.strictEqual(result[0],"mark , how old are you ?")
        done()
    )
)
