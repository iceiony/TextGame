assert = require 'assert'
Transition = require '../nlp/transition'


describe("Matching transitions from the story", ->
  transitionSting = 'Look around/Examine surroundings'
  otherTransitionStrings = [ "look at the tractor/ the tractor ", "paramedics/go to paramedics" ,
                             "body / look at the body / go to body", "what have we got/details / situation"];

  transition = new Transition(transitionSting,otherTransitionStrings);


  it("should match all inputs similar to the property", ->
    assert(transition.match('look around'));
    assert(transition.match('Examine surroundings'));
  )

  it("should match all inputs that contain the property", ->
    assert(transition.match('look around the field'));
    assert(transition.match('explore surrounding field'));
  )

  it("should not match inputs that are arbitrary", ->
    assert(!transition.match("asdf"))
  )

  it("should not match inputs that are strings for other transitions", ->
    assert(!transition.match("look at the tractor"));
  )

  it("should not match inputs that are empty", ->
    assert(!transition.match(""));
  )

  it("should match inputs that are semantically related to the property", ->
    assert(transition.match("analyse surroundings"));
    assert(transition.match("analyse area"));
    assert(transition.match("investigate area"));
    assert(transition.match("checkout surroundings"));
  )
)