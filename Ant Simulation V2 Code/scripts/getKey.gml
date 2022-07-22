///getKey(x,y)
var xx = argument[0];
var yy = argument[1];
var key = string(xx div chunkSize) + "_" + string(yy div chunkSize);
return key;
