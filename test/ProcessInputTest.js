ProcessTest = new TestCase("When the game engine processes the user's input");

ProcessTest.prototype.setUp = function(){

    var mockStory = {
        "initial":{
            content:"Where am I, but more importantly , WHO am I ?",
            "I am Adrian": "remember"
        },
        "remember":{
            content:"Yes, that's it, that is my name. How could I forget"
        }
    };
    StoryLoadTest.Subject = new game.Engine();
    StoryLoadTest.Subject.loadStory(mockStory);
    StoryLoadTest.Subject.state.transfer = function(input){
        StoryLoadTest.wasTransitionCalled = true;
        return input;
    }
};

ProcessTest.prototype["test that engine tries to execute a transition on the state"] = function(){
   StoryLoadTest.Subject.process("input from user");
   assertTrue(StoryLoadTest.wasTransitionCalled);
};