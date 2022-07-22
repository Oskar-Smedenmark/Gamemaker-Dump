///pointInSpawnRange(x,y)
var xx = argument[0];
var yy = argument[1];

//var camD = point_distance(obj_camera.x, obj_camera.y, xx, yy);
var inX = xx >= room_width/2 - spawnRange && xx <= room_width/2 + spawnRange;
var inY = yy >= room_height/2 - spawnRange && yy <= room_height/2 + spawnRange;

var inRange = false;
if(inX && inY)
{
    inRange = true;
}

return inRange;
