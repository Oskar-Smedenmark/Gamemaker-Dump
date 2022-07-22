//If target doesn't exist
if(!instance_exists(target))
{
    return scr_reset_state(false, "NESTING: Target doesn't exist");
}
failedCounter--;
//If you have a target go to it
if(target != noone && !goingToTarget || failedCounter <= 0)
{
    failedCounter = failedTime;
    var unblocked = scr_create_path(path, target.x+16, target.y+16, spd, true);
    if(!unblocked)
    {
        return scr_reset_state(false, "NESTING: Can't reach target");
    }
    goingToTarget = true;
}
if(goingToTarget)
{
    //If you are close enough to the target
    if(distance_to_point(target.x+16, target.y+16) < 8)
    {
        //Create a nest area, add it to the list, delete the order, destroy the target
        var area = instance_create((target.x div TILE_WIDTH) * TILE_WIDTH, (target.y div TILE_HEIGHT) * TILE_HEIGHT, obj_nest_area);
        ds_list_add(obj_world_controller.nestAreas, area);
        ds_list_delete(obj_world_controller.nestOrders, ds_list_find_index(obj_world_controller.nestOrders, target));
        with(target)
        {
            instance_destroy();
        }   
        return scr_reset_state(true, "NESTING: Nesting completed");
    }
}
