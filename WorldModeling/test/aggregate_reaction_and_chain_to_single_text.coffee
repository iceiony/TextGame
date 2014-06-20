assert = require 'assert'
aggregator = require '../model/aggregator'

describe('Aggregating the environment reaction with chains into single string',->


    it('Should aggregate all into a single text with multiple lines for single chain',->
        mockedReaction = 
            text : "Wildcard : Hello"
            chain : [ {text : "Chief : Hi Wildcard"} ]
        
        result = aggregator.aggregate(mockedReaction)
        lineNumber = result.split('\n').length
        assert.equal(2,lineNumber,"Should put each piece of text on a new line");
    )
    
    it('Should aggregate all into a single text with multiple lines for double chain',->
        mockedReaction = 
            text : "Wildcard : Hello"
            chain : [ {text : "Chief : Hi Wildcard"} ,  {text : "Stevey : Hello "} ]
        
        result = aggregator.aggregate(mockedReaction)
        lineNumber = result.split('\n').length
        assert.equal(3,lineNumber,"Should put each piece of text on a new line");
    )
    
    
)