"use strict";
var DefaultFunctionsTest = new TestCase("When no pre transition or render functions are defined");
(function () {
    var Subject,
        wasPreTransitionFunctionUsed,
        wasPreTransitionFunctionChained,
        wasPreRenderFunctionUsed,
        wasPreRenderFunctionChained;

    DefaultFunctionsTest.prototype.setUp = function () {

        Subject = new Game.Engine({
            preTransition: [ "preTransition1", "preTransition2"],
            preRender: [ "preRender1", "preRender2"]
        });
        wasPreTransitionFunctionUsed = false;
        wasPreTransitionFunctionChained = false;
        wasPreRenderFunctionUsed = false;
        wasPreRenderFunctionChained = false;

        Subject.loadCustom({
            "preTransition1" : function (input) {
                wasPreTransitionFunctionUsed = true;
                return input + "custom1 manipulation";
            },
            "preTransition2" : function (input) {
                var substr_start = input.search("custom1 manipulation");
                if (substr_start > 0) {
                    wasPreTransitionFunctionChained = true;
                    return input.substr(0, substr_start);
                }
            },
            "preRender1" : function (new_scene) {
                wasPreRenderFunctionUsed = true;
                return new_scene;
            },
            "preRender2" : function (new_scene) {
                new_scene.content += " Random manipulation at the end";
                wasPreRenderFunctionChained = true;
                return new_scene;
            }
        });

        Subject.state.getCurrent = function () {
            return {
                content: "fake state",
                name: "firstState"
            };
        };

        Subject.state.transition = function (input) {
            return {
                content: "fake state after transfer",
                name: "secondState"
            };
        };
    };

    DefaultFunctionsTest.prototype["test that engine uses the default pre transitions"] = function () {
        Subject.process("I am Adrian");
        assertTrue(wasPreTransitionFunctionUsed);
    };

    DefaultFunctionsTest.prototype["test that engine chains the call for default pre transition"] = function () {
        Subject.process("I am Adrian");
        assertTrue(wasPreTransitionFunctionChained);
    };

    DefaultFunctionsTest.prototype["test that engine uses the default pre render"] = function () {
        Subject.process("I am Adrian");
        assertTrue(wasPreRenderFunctionUsed);
    };

    DefaultFunctionsTest.prototype["test that engine chains the call for default pre render"] = function () {
        Subject.process("I am Adrian");
        assertTrue(wasPreRenderFunctionChained);
    };
}());
