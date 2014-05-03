assert = require 'assert'
semanticCluster = require('../nlp/semanticCluster')
input = ['Look around','Examine surroundings']

describe("SemanticCluster - Generating sentences for #{input}", ->
  it("should return more than just two sentences ", (done)->
    semanticCluster.generateFromAsync(input)
    .done((result, error)->
      assert(result.length > 2);
      
      for sentence in result 
        assert(typeof sentence == 'string', "not a string #{JSON.stringify(sentence)}")
      
      done(error)
    );
  )
)