assert = require 'assert'
Q = require 'Q'
Transition = require '../nlp/transition'

expectedTransition = "Look around/Examine surroundings";
transitionsStrings = [ "look at the tractor/ the tractor ",
                       "paramedics/go to paramedics" ,
                       "body / look at the body / go to body",
                       "what have we got/details / situation"];
transitionsStrings.push(expectedTransition);
transition = new Transition(transitionsStrings);

describe("Transition - Matching transitions for '#{expectedTransition}'", ->
  
  it("should match all inputs that are exactly the same", (done)->
    Q.all([
      transition.matchAsync('look around'),
      transition.matchAsync('Examine surroundings') ])
    .done((result, exception)->
      for element in result
        assert.strictEqual(element.match,expectedTransition, "Failed : #{element.input}");
      done(exception);
    )
  )

  it("should match all inputs that contain the strings", (done)->
    Q.all([
      transition.matchAsync('look around the field'),
      transition.matchAsync('explore surrounding field')    ])
    .done((result, exception)->
      for element in result
        assert.strictEqual(element.match,expectedTransition, "Failed : #{element.input}");
      done(exception);
    )
  )

  it("should not match inputs that are arbitrary", (done)->
    transition.matchAsync("asdf")
    .done((result, exception)->
      assert.notStrictEqual(result.match,expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )

  it("should not match inputs that are strings for other transitions", (done)->
    transition.matchAsync("look at the tractor")
    .done((result, exception)->
      assert.notStrictEqual(result.match,expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )

  it("should not match inputs that are empty", (done)->
    transition.matchAsync("")
    .done((result, exception)->
      assert.notStrictEqual(result.match,expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )

#  it("should match inputs that are semantically related", (done)->
#    Q.all([
#      transition.matchAsync("analyse surroundings"),
#      transition.matchAsync("analyse area"),
#      transition.matchAsync("investigate area"),
#      transition.matchAsync("checkout surroundings"),
#      transition.matchAsync("checkout area")
#    ])
#    .done((result, exception)->
#      for element in result
#        assert.strictEqual(element.match,expectedTransition, "Failed : #{element.input}");
#      done(exception);
#    )
#  )

  it("should not match inputs that are syntax related but not semantically", (done)->
    transition.matchAsync("look at me")
    .done((result, exception)->
      assert.notStrictEqual(result.match,expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )
)
