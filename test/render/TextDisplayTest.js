"use strict";
var TextDisplayTest = TestCase("Text transform");
(function(){
    var textRender,
        mockInput,
        mockOutput,
        mockEngine,
        mockScene = {
            content: "some scene text that is to be displayed<br/>"
        };

    TextDisplayTest.prototype.setUp = function(){
        textRender = Game.Render.Text
        mockInput = jQuery("<input/>",{ id:"input", type:"text" });
        mockOutput =  jQuery("<div/>",{ id:"output" });
        mockEngine = {
            getInputElement: function(){
                return mockInput;
            },
            getOutputElement: function(){
                return mockOutput;
            }
        };
    };

    TextDisplayTest.prototype["test normalRender updates #output with scene content"] = function(){
        textRender.directDisplay.call(mockEngine,mockScene);
        assertSame("some scene text that is to be displayed<br>",mockOutput.html());
    };
}());