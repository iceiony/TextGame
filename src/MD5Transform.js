transform.MD5Transform = function(){};
transform.MD5Transform.prototype = new transform.ClearTransform();

transform.MD5Transform.prototype.hash = function(input){
    return $.md5(input);
}
