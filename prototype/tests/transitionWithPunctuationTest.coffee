assert = require 'assert'
Q = require 'Q'
Transition = require '../nlp/transition'

expectedTransition = "What's the case/What is up/What's the situation/What am I seeing/Information/Details/Situation/What is going on/What have we got/What happened ";
transitionsStrings = [ "Look around/Examine surroundings",
                       "paramedics/go to paramedics" ,
                       "body / look at the body / go to body"];
transitionsStrings.push(expectedTransition);
transition = new Transition(transitionsStrings);


describe("Transition - Matching transitions for #{expectedTransition}", ->
  it("should match transitions when input has punctuation", (done)->
    Q.all([
      transition.matchAsync("what's happening")
    ])
    .done((results, exception)->
      for result in results
        assert.strictEqual(result.match, expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )

  it("should match transitions composed of small words", (done)->
    Q.all([
      transition.matchAsync("what's going on")
      transition.matchAsync("what is up")
      transition.matchAsync("what have we got")
    ])
    .done((results, exception)->
      for result in results
        assert.strictEqual(result.match, expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )

  it("should not match transitions of composed of just What", (done)->
    transition.matchAsync("what")
    .done((result, exception)->
      assert(!result.match, "Should not match : #{result.input}");
      done(exception);
    )
  )
  
)