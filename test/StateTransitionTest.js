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
                    "symbol":"testState",
                    "synonim":"testState",
                    "some text * other text": "wild card state 2",
                    "*": "wild card state"
                }
            }
        };

        //actual state persistance
        localStorage.persistantState = JSON.stringify(mockState);
        localStorage.currentStateKey = "initial";
        Subject =new Game.StateManager();
    };

    StateTest.prototype["test state will transfer for symbol passed"] = function(){
        assertSame("Transfer state text",Subject.transfer("symbol"));
        assertSame("testState",localStorage.currentStateKey);
        assertSame("testState",Subject.getCurrent().name);
    };

    StateTest.prototype["test state will transfer for synonim of symbol"] = function(){
       assertSame("Transfer state text",Subject.transfer("synonim"));
       assertSame("testState",localStorage.currentStateKey);
    };

    StateTest.prototype["test that if no transition exists the state does not change"] = function()
    {
        Subject.transfer("symbol");
        Subject.transfer("random input");
        assertSame("testState",localStorage.currentStateKey);
    };

    StateTest.prototype["test the state can have wild card transitions for arbitrary input"] = function(){
        Subject.transfer("asfasfasdf");
        assertSame("wild card state",localStorage.currentStateKey);
    };

    StateTest.prototype["test the state  can have transitions with wild card placeholders"] = function(){
        Subject.transfer("some text asfasfasdf other text");
        assertSame("wild card state 2",localStorage.currentStateKey);
    };
}());