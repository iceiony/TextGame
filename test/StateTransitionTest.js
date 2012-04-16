StateTest = TestCase("State");

StateTest.prototype.setUp= function(){

   /* given an existing local storage*/
   localStorage.state = new Object();
   localStorage.state["current"] = "initial";
   localStorage.state["initial"] = {
                                    content:"Initial state text",
                                    "symbol": "symbol",
                                    "synonim": "symbol"
                                    };
   localStorage.state["symbol"] = {
       content:"Transfer state text"
   };

    /* create a state object as the test subject*/
    StateTest.Subject = new game.State();
}

StateTest.prototype["test state transfer for symbol"] = function(){
    assertSame("Transfer state text",StateTest.Subject.transfer("symbol"));
}

StateTest.prototype["test state transfer for synonim"] = function(){
   assertSame("Transfer state text",StateTest.Subject.transfer("synonim"));
}
