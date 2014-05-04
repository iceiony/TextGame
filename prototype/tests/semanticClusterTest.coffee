assert = require 'assert'
semanticCluster = require('../nlp/semanticCluster')
input = ['Look around','Examine surroundings']

describe("SemanticCluster - Generating sentences for #{input}", ->
  it("should return more than just two sentences ", (done)->
    semanticCluster.generateFromAsync(input)
    .done((result, error)->
      assert(result.length > 2);
      
      for sentence in result
        asString = JSON.stringify(sentence)
        assert(typeof sentence == 'string', "not a string #{asString}")
      
      done(error)
    );
  )
)