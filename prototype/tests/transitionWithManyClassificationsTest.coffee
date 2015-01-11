assert = require 'assert'
Q = require 'q'
Transition = require '../nlp/transition'

expectedTransition = 'you found the body/how did you find the body/how did you find it/ask about body'
transitionsStrings = [ "Cigar/Fag/Smoke/have a smoke"
                        ""
                        "coffee/give me coffee"
                        "chief's name/what is your name chief"
                        "Look at body / Go to body/ inspect body"
                        "Paramedics/go to paramedics/talk to paramedics"
                        "tractor/inspect tractor/examine tractor/go to tractor"
                        "farmer/go to farmer/talk to farmer"
                        "default"
                        "take medication"
                        "yes"
                        "no"
                        "he fell from the sky/he fell from large height / he fell from height/he fell from balloon / he fell from plane"
                        "get water/ask for water/request water/give me water"
                        "take medication/drink water"
                        "what is your name/ask name"
                        "hello/ greetings"
                        "where are you from"
                        "what do you do/working on what/what are you working on"
                        "why"
                        "wtf/what the fuck"
                        "lol/haha/hahaha"
                        "why Sunday/you work Sunday/working sunday"
                        "you have been drinking/drunk/drunk driving/drunk at work"
                        "who is edd"
                        "drive tractor/drive it/drive"
                        "hello/greetings"
                        "how do you do"
                        "not yet/don't know/No"
                        "yes"
                        "hit by tractor/hit with tractor/run over"
                        "no/don't think so"
                        "hit by tractor/hit with tractor/run over/yes"
                        "i thought you are Mark/wasn't your name Mark/ your name is Mark"
                      ];

transitionsStrings.push(expectedTransition);
transition = new Transition(transitionsStrings);


describe('Transition - With many elements to classify',->
  it("should match the expected transition correctly - [#{expectedTransition}]", (done)->
    transition.matchAsync('how did you find the body')
    .done((result, exception)->
      assert.strictEqual(result.match,expectedTransition, "Failed : #{result.input}");
      done(exception);
    )
  )
)