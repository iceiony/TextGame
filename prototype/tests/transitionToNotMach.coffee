assert = require 'assert'
Q = require 'Q'
Transition = require '../nlp/transition'

transitionsStrings = [ "Look around/Examine surroundings"
                       "paramedics/go to paramedics"
                       "body / look at the body / go to body"
                       "Cigar/Fag/Smoke/have a smoke"
                       "What's the case/What is up/What's the situation/What am I seeing/Information/Details/Situation/What is going on/What have we got/What happened "
];
transition = new Transition(transitionsStrings);


describe("Transition - Should not mach any of the transitions", ->
  it("should not match related but semantically related questions like What is your name", (done)->
    transition.matchAsync("what is your name")
    .done((result, exception)->
      assert(!result.match, "#{result.input} should not match : #{result.match} - with ratio #{result.ratio}");
      done(exception);
    )
  )

  it("should not the transition containing only the letter a", (done)->
    transition.matchAsync("a")
    .done((result, exception)->
      assert(!result.match, "#{result.input} should not match : #{result.match} - with ratio #{result.ratio}");
      done(exception);
    )
  )
)