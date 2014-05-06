assert = require 'assert'
Q = require 'Q'
Transition = require '../nlp/transition'

expectedTransition = "What is the case/What's the situation/ What am I seeing / Details /Situation / what is going on / what have we got / where is the body / so / what happened ";
transitionsStrings = [ "Look around/Examine surroundings",
                       "paramedics/go to paramedics" ,
                       "body / look at the body / go to body",
                       "what have we got/details / situation"];
transitionsStrings.push(expectedTransition);
transition = new Transition(transitionsStrings);


describe("Transition - Matching transitions for #{expectedTransition}", ->

  it("should match transitions when input has punctuation", (done)->
    transition.matchAsync("what's the case?")
    .done((result, exception)->
      assert.strictEqual(result.match,expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )

)