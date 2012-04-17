StateTest = TestCase("State");

StateTest.prototype.setUp= function(){

   /* given an existing local storage*/
   fakeState = {};

    //state map object
    fakeState["symbol"] = {
        content:"Transfer state text"
    };
    fakeState["initial"] = {
                                    "content":"Initial state text",
                                    "symbol":"symbol",
                                    "synonim":"symbol"
                                    };
    fakeState["current"] = "initial";

    //actual state persistance
    localStorage.persistateState = JSON.stringify(fakeState);
    localStorage.currentStateKey = "current";

    /* create a state object as the test subject*/
    StateTest.Subject = new game.State();
}

StateTest.prototype["test state transfer for symbol"] = function(){
    assertSame("Transfer state text",StateTest.Subject.transfer("symbol"));
    assertSame("symbol",localStorage.currentStateKey);
}

StateTest.prototype["test state transfer for synonim"] = function(){
   assertSame("Transfer state text",StateTest.Subject.transfer("synonim"));
    assertSame("synonim",localStorage.currentStateKey);
}
