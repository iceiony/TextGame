"use strict";
var StoryLoadTest = new TestCase("When loading the game story");
(function () {
    var Subject,
        wasScenePrepared;

    StoryLoadTest.prototype.setUp = function () {
        wasScenePrepared = false;
        var mockStory = {
            "initial": {
                defaultRender: ["assertPrepare"],
                content: "Where am I, but more importantly , WHO am I ?",
                transitions: {
                    "remember": "I am Adrian"
                }
            },
            "remember": {
                content: "Yes, that's it, that is my name. How could I forget"
            }
        };


        delete (localStorage.persistantState);
        delete (localStorage.currentStateKey);

        Subject = new Game.Engine();
        Subject.loadCustom({
            "assertPrepare": function (input) {
                wasScenePrepared = true;
            }
        });
        Subject.loadStory(mockStory);
    };

    StoryLoadTest.prototype["test that the state is holding the story transitions"] = function () {
        assertSame("Yes, that's it, that is my name. How could I forget", Subject.state.transition("I am Adrian").content);
    };

    StoryLoadTest.prototype["test that the state is saved immediately in the local session"] = function () {
        assertSame("initial", localStorage.currentStateKey);
        assertNotUndefined(localStorage.persistantState);
    };

    StoryLoadTest.prototype["test that the engine has prepared the new scene"] = function () {
        assertTrue(wasScenePrepared);
    };
}());