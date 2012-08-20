"use strict";
var PreRenderTest = new TestCase("When the game engine processes the user's input with postTransition speciffied");
(function(){
    var Subject ,
        wasPostProcessingUsed,
        wasPostProcessingChained,
        localThis;

    PreRenderTest.prototype.setUp = function(){
        Subject = new Game.Engine();
        wasPostProcessingUsed=false;
        wasPostProcessingChained= false,
        localThis = undefined;

        Subject.loadCustom({
            "doSomePostRecording" : function(new_scene){
                wasPostProcessingUsed=true;
                localThis = this;
                return new_scene;
            },
            "doSomePostManipulation" : function(new_scene){
                new_scene.content += " Random manipulation at the end";
                wasPostProcessingChained =true;
                return new_scene;
            }
        });

        var mockStory = {
            "initial":{
                content:"Where am I, but more importantly , WHO am I ?",
                transitions:{
                    "remember" : "I am Adrian"
                }
            },
            "remember":{
                preRender:["doSomePostRecording","doSomePostManipulation"],
                content:"Yes, that's it, that is my name. How could I forget"
            }
        };
        Subject.loadStory(mockStory);
    };

    PreRenderTest.prototype["test that engine uses the postTransition functions specified"] = function(){
        Subject.process("I am Adrian");
       assertTrue(wasPostProcessingUsed);
    };

    PreRenderTest.prototype["test that engine chains the call for functions in postTransition"] = function(){
        Subject.process("I am Adrian");
        assertTrue(Subject.state.getCurrent().content.search("Random manipulation at the end")>=0);
        assertTrue(wasPostProcessingChained);
    };

    PreRenderTest.prototype["test that the local 'this' points to the Subject ( Game.Engine instance )"] = function(){
        Subject.process("I am Adrian");
        assertSame(Subject,localThis);
    };
}());
