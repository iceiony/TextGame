ProcessTest = new TestCase("When the game engine processes the user's input");

ProcessTest.prototype.setUp = function(){

    var mockStory = {
        "initial":{
            functions:["custom1"],
            content:"Where am I, but more importantly , WHO am I ?",
            "I am Adrian": "remember"
        },
        "remember":{
            content:"Yes, that's it, that is my name. How could I forget"
        }
    };
    StoryLoadTest.Subject = new game.Engine();
    StoryLoadTest.Subject.custom["custom1"] = function(input){StoryLoadTest.wasTransictionFunctionUsed=true;return input;};

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

ProcessTest.prototype["test that engine uses the transition functions specified in the state object when transfering state"] = function(){
   StoryLoadTest.Subject.process("input from user");
   assertTrue(StoryLoadTest.wasTransictionFunctionUsed);
};

