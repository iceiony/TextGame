"use strict";
var StoryLoadTest = new TestCase("When loading the game story");
(function(){
    var Subject;

    StoryLoadTest.prototype.setUp = function(){
        var mockStory = {
            "initial":{
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
        Subject.loadStory(mockStory);
    };

    StoryLoadTest.prototype["test that the state is holding the story transitions"] = function(){
        assertSame("Yes, that's it, that is my name. How could I forget", Subject.state.transition("I am Adrian").content);
    };

    StoryLoadTest.prototype["test that the state is saved immediately in the local session"] = function(){
        assertSame("initial",localStorage.currentStateKey);
        assertNotUndefined(localStorage.persistantState);
    };
}());