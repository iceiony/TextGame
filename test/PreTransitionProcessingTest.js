"use strict";
var PreTransitionTest = new TestCase("When the game engine processes the user's input with preTransition functions speciffied");
(function () {
    var Subject,
        defaultTransferFunction,
        wasTransitionFunctionUsed,
        wasTransitionCalled,
        wasFunctionChained;

    PreTransitionTest.prototype.setUp = function () {
        Subject = new Game.Engine();
        wasTransitionFunctionUsed = false;
        wasTransitionCalled = false;
        wasFunctionChained = false;

        Subject.loadCustom({
            "custom1" : function (input) {
                wasTransitionFunctionUsed = true;
                return input + "custom1 manipulation";
            },
            "custom2" : function (input) {
                var substr_start = input.search("custom1 manipulation");
                if (substr_start > 0) {
                    wasFunctionChained = true;
                    return input.substr(0, substr_start);
                }
            }
        });

        var mockStory = {
            "initial": {
                content: "Where am I, but more importantly , WHO am I ?",
                atTransition: ["custom1", "custom2"],
                transitions: {
                    "remember": "I am Adrian"
                }
            },
            "remember": {
                content: "Yes, that's it, that is my name. How could I forget"
            }
        };

        Subject.loadStory(mockStory);

        defaultTransferFunction = Subject.state.transition;
        Subject.state.transition = function (input) {
            wasTransitionCalled = true;
            return defaultTransferFunction.call(Subject.state, input);
        };
    };

    PreTransitionTest.prototype["test that engine tries to execute a transition on the state"] = function () {
        Subject.process("I am Adrian");
       assertTrue(wasTransitionCalled);
    };

    PreTransitionTest.prototype["test that engine uses the preTransition functions specified"] = function () {
        Subject.process("I am Adrian");
       assertTrue(wasTransitionFunctionUsed);
    };

    PreTransitionTest.prototype["test that engine chains the call for functions in preTransition"] = function () {
        Subject.process("I am Adrian");
        assertEquals("remember",Subject.state.getCurrent().name);
        assertTrue(wasFunctionChained);
    };
}());
