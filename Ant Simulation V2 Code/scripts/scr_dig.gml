///scr_dig()
//Lost the target even if ant hasn't dug yet
if(!instance_exists(target) && !digDone)
{
    return scr_reset_state(false, "DIGGING: Target doesn't exists and I haven't done digging");
}

var digTarget = noone;
var ant = id;
//Get your path target
with(obj_dig_target)
{
    if(owner == ant)
    {
        digTarget = id;
    }
}
//If you have a dig target go to it
if(digTarget != noone)
{
    var unblocked = scr_create_path(path, digTarget.x+16, digTarget.y+16, spd, true);
    if(!unblocked)
    {
        return scr_reset_state(false, "DIGGING: Can't reach target");
    }
}
//If you are close enough to the solid and haven't dug yet
if(!digDone && distance_to_object(target) <= 32)
{   
    //Remove the cell from the grid, delete the order from the list and delete the solid
    scr_remove_cell(target.x div TILE_WIDTH + global.offsetX, target.y div TILE_HEIGHT + global.offsetY);
    ds_list_delete(obj_world_controller.digOrders, ds_list_find_index(obj_world_controller.digOrders, target));
    with(target)
    {
        instance_destroy();
    }
    digDone = true;
}
//If you have dug wait a few moments then go idle
if(digDone)
{
    digDoneCounter--;
    if(digDoneCounter <= 0)
    {
        digDoneCounter = digDoneTime;
        digDone = false;
        return scr_reset_state(true, "DIGGING: Done digging");
    }
}
