"use strict";
var HashFunctions = TestCase("Input transform");
(function(){
    var Transform = Game.Input.Transform;

    HashFunctions.prototype["test the MD5Transform function hashes the given imput to an md5 byte string"] = function(){
        assertSame("e59f088359c343614fb86f52b839b42f",Transform.md5Hash("the text I want to hash"));
    };

    HashFunctions.prototype["test the ClearTransform function outputs the same value as the input"] = function(){
        assertSame("some random input", Transform.lowerCase("Some Random Input"));
    };
}());