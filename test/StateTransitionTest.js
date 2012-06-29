StateTest = TestCase("When State is used with a ClearTransform");

StateTest.prototype.setUp= function(){

   /* given an existing local storage*/
    var fakeState = {
        "testState":{
            content:"Transfer state text"
        },
        "wild card state":{
            content:"some state text "
        },
        "initial":{
            content:"Initial state text",
            "symbol":"testState",
            "synonim":"testState",
            "*": "wild card state"
        },
        "current":"initial"
    };

    //actual state persistance
    localStorage.persistantState = JSON.stringify(fakeState);
    localStorage.currentStateKey = "current";

    /* create a state object as the test subject*/
    StateTest.mockTransformFunction = function(input){
        StateTest.wasHashInvoked = true;
        return input;
    };
    StateTest.Subject = new game.State(StateTest.mockTransformFunction);
};

StateTest.prototype["test state will transfer for symbol passed"] = function(){
    assertSame("Transfer state text",StateTest.Subject.transfer("symbol"));
    assertSame("testState",localStorage.currentStateKey);
};

StateTest.prototype["test state will transfer for synonim of symbol"] = function(){
   assertSame("Transfer state text",StateTest.Subject.transfer("synonim"));
   assertSame("testState",localStorage.currentStateKey);
};

StateTest.prototype["test the State obect uses transformation on imput before transfer "] = function(){
    StateTest.Subject.transfer("symbol")
    assertTrue(StateTest.wasHashInvoked);
};

StateTest.prototype["test the state can have wild card transitions for arbitrary input"] = function(){
    StateTest.Subject.transfer("asfasfasdf");
    assertSame("wild card state",localStorage.currentStateKey);
}