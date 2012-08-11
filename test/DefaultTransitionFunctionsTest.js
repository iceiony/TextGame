"use strict";
var DefaultFunctionsTest = new TestCase("When the game engine processes the user's input with no preProcessing or preRender functions defined");
(function(){
    var Subject = new Game.Engine(),
        wasPreTransitionFunctionUsed=false,
        wasPreTransitionFunctionChained=false,
        wasPreRenderFunctionUsed=false,
        wasPreRenderFunctionChained=false;

    DefaultFunctionsTest.prototype.setUp = function(){

        Subject = new Game.Engine({
            preTransition:["preTransition1","preTransition2"],
            preRender:["preRender1","preRender2"]
        });

        Subject.custom = {
            "preTransition1" : function(input){
                wasPreTransitionFunctionUsed=true;
                return input+"custom1 manipulation";
            },
            "preTransition2" : function(input){
                var substr_start = input.search("custom1 manipulation");
                if(substr_start>0){
                    wasPreTransitionFunctionChained=true;
                    return input.substr(0,substr_start);
                };
            },
            "preRender1" : function(new_scene){
                wasPreRenderFunctionUsed=true;
                return new_scene;
            },
            "preRender2" : function(new_scene){
                new_scene.content += " Random manipulation at the end";
                return new_scene;
            }
        };

        Subject.state.getCurrent() = {
            content:"fake state",
            name:"firstState"
        };
        Subject.state.transition = function(input){
            return {
                content:"fake state after transfer",
                name:"secondState"
            };
        };
    };

    DefaultFunctionsTest.prototype["test that engine uses the default pre transitions"] = function(){
        Subject.process("I am Adrian");
        assertTrue(wasPreTransitionFunctionUsed);
    };

    DefaultFunctionsTest.prototype["test that engine chains the call for default pre transition"] = function(){
        Subject.process("I am Adrian");
        assertEquals("secondState",Subject.state.getCurrent().name);
        assertTrue(wasPreTransitionFunctionChained);
    };

    DefaultFunctionsTest.prototype["test that engine uses the default pre render"] = function(){
        Subject.process("I am Adrian");
        assertTrue(wasPreRenderFunctionUsed);
    };

    DefaultFunctionsTest.prototype["test that engine chains the call for default pre render"] = function(){
        assertEquals(Subject.state.getCurrent().content.search("Random manipulation at the end")>=0);
        assertTrue(wasPreRenderFunctionChained);
    };
}());
