"use strict";
var PreRenderTest = new TestCase("When the game engine processes the user's input with postTransition speciffied");
(function () {
    var Subject,
        wasPostProcessingUsed,
        wasPostProcessingChained,
        localThis;

    PreRenderTest.prototype.setUp = function () {
        wasPostProcessingUsed = false;
        wasPostProcessingChained = false;
        localThis = undefined;

        delete (localStorage.persistantState);
        delete (localStorage.currentStateKey);
        Subject = new Game.Engine();

        Subject.loadCustom({
            "doSomePostRecording" : function (new_scene) {
                wasPostProcessingUsed = true;
                localThis = this;
                return new_scene;
            },
            "doSomePostManipulation" : function (new_scene) {
                new_scene.content += " Random manipulation at the end";
                wasPostProcessingChained = true;
                return new_scene;
            }
        });

        var mockStory = {
            "initial": {
                content:"Where am I, but more importantly , WHO am I ?",
                transitions: {
                    "remember" : "I am Adrian"
                }
            },
            "remember": {
                atRender: ["doSomePostRecording", "doSomePostManipulation"],
                content: "Yes, that's it, that is my name. How could I forget"
            }
        };
        Subject.loadStory(mockStory);
    };

    PreRenderTest.prototype["test the engine uses the postTransition functions specified"] = function () {
        Subject.process("I am Adrian");
       assertTrue(wasPostProcessingUsed);
    };

    PreRenderTest.prototype["test the engine chains the call for functions in postTransition"] = function () {
        Subject.process("I am Adrian");
        assertTrue(Subject.state.getCurrent().content.search("Random manipulation at the end") >= 0);
        assertTrue(wasPostProcessingChained);
    };

    PreRenderTest.prototype["test the local 'this' points to the Subject ( Game.Engine instance )"] = function () {
        Subject.process("I am Adrian");
        assertSame(Subject, localThis);
    };

    PreRenderTest.prototype["test no render is made if state did not change"] = function () {
        Subject.process("I am Adrian");
        wasPostProcessingUsed = false;
        wasPostProcessingChained = false;
        Subject.process("asdf");
        assertFalse(wasPostProcessingUsed);
        assertFalse(wasPostProcessingChained);
    };
}());
