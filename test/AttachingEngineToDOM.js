"use strict";
var AttachingEngineToDOM = new TestCase("When creating a new engine with the DOMParent parameter passed");

(function(){
    AttachingEngineToDOM.prototype["test that the engine attaches to a given DOM element and creates input and output elements"]=function(){
        var element = document.createElement("div"),
            Subject = new Game.Engine({
                DOMParent:element
            });
        assertTrue($(element).find("#input").length>0);
        assertTrue($(element).find("#output").length>0);
    };
    AttachingEngineToDOM.prototype["test that the engine attached to given DOM ID and creates input and output elements"]=function(){
        /*:DOC += <div id="container">some text</div> */
        var Subject = new Game.Engine({
                DOMParent:"container"
            });

        assertTrue($("#input").length>0);
        assertTrue($("#output").length>0);
    };
    AttachingEngineToDOM.prototype["test that the engine exposes the parentElement,inputElement and outputElement"] = function(){
        /*:DOC += <div id="container">some text</div> */
        var Subject = new Game.Engine({
            DOMParent:"container"
        });

        $("#input").text("some ipnut text");
        $("#output").text("some output text");

        assertSame($("#input").text(),$(Subject.getInputElement()).text());
        assertSame($("#output").text(),$(Subject.getOutputElement()).text());
        assertSame($("#container").text(),$(Subject.getParentElement()).text());
    };
    AttachingEngineToDOM.prototype["test that the engine creates the input inside a form that does not propagate events"] = function(){
        /*:DOC += <div id="container">some text</div> */
        var Subject = new Game.Engine({
            DOMParent:"container"
        });
        assertSame("FORM",$("#input").parent().get(0).tagName);
    };
}());