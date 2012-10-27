"use strict";
var ManagingCustoms = new TestCase("When loading custom functions in multiple steps and with non duplicate names");
(function () {
    var Subject,
        wasFirstFunctionCalled,
        wasSecondFunctionCalled,
        wasOverwritingFunctionCalled;

    ManagingCustoms.prototype.setUp = function () {
        Subject = new Game.Engine();
        wasFirstFunctionCalled = false;
        wasSecondFunctionCalled = false;
        wasOverwritingFunctionCalled = false;

        Subject.loadCustom({
            "firstFunction": function (input) {
                wasFirstFunctionCalled = true;
                return input;
            }
        });

        Subject.loadCustom({
            "secondFunction": function (input) {
                wasSecondFunctionCalled = true;
                return input;
            }
        });

        var mockStory = {
            "initial": {
                content: "Where am I, but more importantly , WHO am I ?",
                transitions: {
                    "remember": "I am Adrian"
                }
            },
            "remember": {
                defaultRender: ["firstFunction","secondFunction"],
                content: "Yes, that's it, that is my name. How could I forget"
            }
        };
        Subject.loadStory(mockStory);
    };

    ManagingCustoms.prototype["test that the first function is executed"] = function () {
        Subject.process("I am Adrian");
        assertTrue(wasFirstFunctionCalled);
    };

    ManagingCustoms.prototype["test that the second function is executed"] = function () {
        Subject.process("I am Adrian");
        assertTrue(wasSecondFunctionCalled);
    };

    ManagingCustoms.prototype["test that loading the same function name will overwrite the previous one"] = function () {
        wasFirstFunctionCalled = false;
        wasSecondFunctionCalled = false;
        wasOverwritingFunctionCalled = false;

        Subject.loadCustom({
            "secondFunction": function (input) {
                wasOverwritingFunctionCalled = true;
                return input;
            }
        });
        Subject.process("I am Adrian");
        assertTrue(wasOverwritingFunctionCalled);
        assertFalse(wasSecondFunctionCalled);
    };

}());
