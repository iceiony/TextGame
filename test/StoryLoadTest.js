"use strict";
var StoryLoadTest = new TestCase("When loading the game story");

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
    StoryLoadTest.Subject = new game.Engine();
    StoryLoadTest.Subject.loadStory(mockStory);
};

StoryLoadTest.prototype["test that the state is holding the story transitions"] = function(){
    assertSame("Yes, that's it, that is my name. How could I forget", StoryLoadTest.Subject.state.transfer("I am Adrian"));
};

StoryLoadTest.prototype["test that the state is saved immediately in the local session"] = function(){
    assertSame("initial",localStorage.currentStateKey);
    assertNotUndefined(localStorage.persistantState);
};