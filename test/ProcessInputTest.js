"use strict";
var ProcessTest = new TestCase("When the game engine processes the user's input");
(function(){
    var Subject = new Game.Engine(),
        wasTransictionFunctionUsed=false,
        wasTransitionCalled=false;

    ProcessTest.prototype.setUp = function(){

        var mockStory = {
            "initial":{
                functions:["custom1"],
                content:"Where am I, but more importantly , WHO am I ?",
                transitions:{
                              "I am Adrian": "remember"
                }
            },
            "remember":{
                content:"Yes, that's it, that is my name. How could I forget"
            }
        };
        Subject = new Game.Engine();
        Subject.custom["custom1"] = function(input){
            wasTransictionFunctionUsed=true;return input;};

        Subject.loadStory(mockStory);
        Subject.state.transfer = function(input){
            wasTransitionCalled = true;
            return input;
        }
    };

    ProcessTest.prototype["test that engine tries to execute a transition on the state"] = function(){
        Subject.process("input from user");
       assertTrue(wasTransitionCalled);
    };

    ProcessTest.prototype["test that engine uses the transition functions specified in the state object when transfering state"] = function(){
        Subject.process("input from user");
       assertTrue(wasTransictionFunctionUsed);
    };
}());
