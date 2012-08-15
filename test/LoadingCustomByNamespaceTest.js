"use strict";
var NamespaceCustom = new TestCase("When loading customs by namespace");
(function(){
    var Subject = new Game.Engine(),
        wasFunctionCalled = false;

    NamespaceCustom.prototype.setUp = function(){
        Subject = new Game.Engine();

        Game.namespace("Game.FakeCustom");
        Game.FakeCustom.myCustomFunctionn = function(input){
                wasFunctionCalled=true;
                return input;
        };

        Subject.loadCustom(["Game.FakeCustom.myCustomFunctionn"]);

        var mockStory = {
            "initial": {
                content: "Where am I, but more importantly , WHO am I ?",
                transitions: {
                    "remember": "I am Adrian"
                }
            },
            "remember": {
                preRender: ["Game.FakeCustom.myCustomFunctionn"],
                content: "Yes, that's it, that is my name. How could I forget"
            }
        };
        Subject.loadStory(mockStory);
    };

    NamespaceCustom.prototype["test that the function is executed"] = function(){
        Subject.process("I am Adrian");
        assertTrue(wasFunctionCalled);
    };

}());
