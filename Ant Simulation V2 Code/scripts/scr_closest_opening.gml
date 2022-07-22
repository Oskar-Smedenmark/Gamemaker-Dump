///scr_closest_opening(target)
var closestX = -1;
var closestY = -1;
var closest = 99999;
var xx = 0;
var yy = 0;
if(!instance_exists(argument[0]))
{
    return noone;
}
//Get targets position in the grid 
var gridX = getOffsetX(argument[0].x);
var gridY = getOffsetY(argument[0].y);

//Left empty
if(obj_world_controller.solidGrid[# gridX - 1, gridY] == 0)
{
    var unblocked = scr_create_path(path, argument[0].x - 32, argument[0].y, 0, false);
    if(path_get_length(path) <= closest && unblocked)
    {
        closestX = argument[0].x - 32;
        closestY = argument[0].y;
        closest = path_get_length(path);
    }
}
//Right empty
if(obj_world_controller.solidGrid[# gridX + 1, gridY] == 0)
{
    var unblocked = scr_create_path(path, argument[0].x + 32, argument[0].y, 0, false);
    if(path_get_length(path) <= closest && unblocked)
    {
        closestX = argument[0].x + 32;
        closestY = argument[0].y;
        closest = path_get_length(path);
    }
}
//Up empty
if(obj_world_controller.solidGrid[# gridX, gridY - 1] == 0)
{
    var unblocked = scr_create_path(path, argument[0].x, argument[0].y - 32, 0, false);
    if(path_get_length(path) <= closest && unblocked)
    {
        closestX = argument[0].x;
        closestY = argument[0].y - 32;
        closest = path_get_length(path);
    }
}
//Down empty
if(obj_world_controller.solidGrid[# gridX, gridY + 1] == 0)
{
    var unblocked = scr_create_path(path, argument[0].x, argument[0].y + 32, 0, false);
    if(path_get_length(path) <= closest && unblocked)
    {
        closestX = argument[0].x;
        closestY = argument[0].y + 32;
        closest = path_get_length(path);
    }
}

//No empty spot
if(closestX == -1 || closestY == -1)
{
    return noone;
}
else
{
    return instance_create(closestX, closestY, obj_dig_target);
}
