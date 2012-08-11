"use strict";
var StateTest = TestCase("When current State is used with a ClearTransform");

(function(){
    var Subject;

    StateTest.prototype.setUp= function(){

       /* given an existing local storage*/
        var mockState = {
            "testState":{
                content:"Transfer state text"
            },
            "wild card state":{
                content:"some state text "
            },
            "wild card state 2":{
                content:"some state text "
            },
            "initial":{
                content:"Initial state text",
                transitions:{
                    "testState":["symbol","synonim"],
                    "wild card state 2": ["some text * other text"] ,
                    "wild card state": ["*"]
                }
            }
        };

        //actual state persistance
        localStorage.persistantState = JSON.stringify(mockState);
        localStorage.currentStateKey = "initial";
        Subject =new Game.StateManager();
    };

    StateTest.prototype["test state will transfer for symbol passed"] = function(){
        assertSame("Transfer state text",Subject.transition("symbol").content);
        assertSame("testState",localStorage.currentStateKey);
        assertSame("testState",Subject.getCurrent().name);
    };

    StateTest.prototype["test state will transfer for synonim of symbol"] = function(){
       assertSame("Transfer state text",Subject.transition("synonim").content);
       assertSame("testState",localStorage.currentStateKey);
    };

    StateTest.prototype["test that if no transition exists the state does not change"] = function()
    {
        Subject.transition("symbol");
        Subject.transition("random input");
        assertSame("testState",localStorage.currentStateKey);
    };

    StateTest.prototype["test the state can have wild card transitions for arbitrary input"] = function(){
        Subject.transition("asfasfasdf");
        assertSame("wild card state",localStorage.currentStateKey);
    };

    StateTest.prototype["test the state  can have transitions with wild card placeholders"] = function(){
        Subject.transition("some text asfasfasdf other text");
        assertSame("wild card state 2",localStorage.currentStateKey);
    };
}());