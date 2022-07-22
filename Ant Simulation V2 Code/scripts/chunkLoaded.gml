///chunkLoaded(x,y)
var xx = argument[0];
var yy = argument[1];
var exists = ds_map_exists(chunkLoadedSet, getKey(xx,yy));
return exists;
