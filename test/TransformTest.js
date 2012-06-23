HashFunctions = TestCase("Transform functions on user text");

HashFunctions.prototype["test the MD5Transform function hashes the given imput to an md5 byte string"] = function(){
    assertSame("e59f088359c343614fb86f52b839b42f",hash.md5Hash("the text I want to hash"));
}

HashFunctions.prototype["test the ClearTransform function outputs the same value as the input"] = function(){
    assertSame("some random input", hash.clearHash("some random input"));
}