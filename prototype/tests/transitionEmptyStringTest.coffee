assert = require 'assert'
Q = require 'Q'
Transition = require '../nlp/transition'

expectedTransition = "";
transitionsStrings = [ "Look around/Examine surroundings",
                       "look at the tractor/ the tractor ",
                       "paramedics/go to paramedics" ,
                       "body / look at the body / go to body",
                       "what have we got/details / situation"];
transitionsStrings.push(expectedTransition);
transition = new Transition(transitionsStrings);

describe("Transition - Matching transitions for an empty string", ->

  it("should match transitions that are empty strings", (done)->
    transition.matchAsync('')
    .done((result, exception)->
      assert.strictEqual(result.match,expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )
  
  it("should match other transitions to their key string", (done)->
    Q.all([
      transition.matchAsync('look around'),
      transition.matchAsync('Examine surroundings') ])
    .done((result, exception)->
      for element in result
        assert.notStrictEqual(element.match,expectedTransition, "Failed : #{element.input}");
        assert(element.match, "Failed : #{element.input}");
      done(exception);
    )
  )
)