"use strict";
var ProcessTest = new TestCase("When the game engine processes the user's input");
(function(){
    var Subject = new Game.Engine(),
        wasTransictionFunctionUsed=false,
        wasPreTransitionCalled=false,
        wasFunctionChained= false;

    ProcessTest.prototype.setUp = function(){

        Subject = new Game.Engine();
        Subject.custom = {
            "custom1" : function(input){
                wasTransictionFunctionUsed=true;
                return input+"custom1 manipulation";
            },
            "custom2" : function(input){
                var substr_start = input.search("custom1 manipulation");
                if(substr_start>0){
                    wasFunctionChained=true;
                    return input.substr(0,substr_start);
                }
            }
        }

        var mockStory = {
            "initial":{
                content:"Where am I, but more importantly , WHO am I ?",
                preTransition:["custom1","custom2"],
                transitions:{
                  "I am Adrian": "remember"
                }
            },
            "remember":{
                content:"Yes, that's it, that is my name. How could I forget"
            }
        };

        Subject.loadStory(mockStory);
        Subject.state.transfer = function(input){
            wasPreTransitionCalled = true;
            return input;
        }
    };

    ProcessTest.prototype["test that engine tries to execute a transition on the state"] = function(){
        Subject.process("input from user");
       assertTrue(wasPreTransitionCalled);
    };

    ProcessTest.prototype["test that engine uses the preTransition functions specified"] = function(){
        Subject.process("input from user");
       assertTrue(wasTransictionFunctionUsed);
    };

    ProcessTest.prototype["test that engine chains the call for functions in preTransition"] = function(){
        Subject.process("input from user");
        assertTrue(wasFunctionChained);
    };
}());
