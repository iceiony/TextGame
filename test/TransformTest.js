MD5TransformTest = TestCase("MD5");

MD5TransformTest.prototype.setUp = function () {
    MD5TransformTest.Subject = new transform.MD5Transform();
    console.log($.md5);
}

MD5TransformTest.prototype["test the transform hashes the given imput to an md5 byte string"] = function(){
    assertSame("e59f088359c343614fb86f52b839b42f",MD5TransformTest.Subject.hash("the text I want to hash"));
}

ClearTransformTest = TestCase("ClearTransform");

ClearTransformTest.prototype.setUp = function () {
    ClearTransformTest.Subject = new transform.ClearTransform();
}

ClearTransformTest.prototype["test the transform hash outputs the same value as the input"] = function(){
    assertSame("some random input",ClearTransformTest.Subject.hash("some random input"));
}