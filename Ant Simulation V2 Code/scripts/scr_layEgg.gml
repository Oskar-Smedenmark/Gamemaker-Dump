///scr_layEgg()
//Checks if ant got a target
if(target == noone)
{
    //Get a random index from all of the nest areas
    var ind = irandom(ds_list_size(obj_world_controller.nestAreas)-1);
    var area = ds_list_find_value(obj_world_controller.nestAreas, ind);
    target = area;
    xTo = area.x + 16;
    yTo = area.y + 16;
    //Create a path to the target
    if(!scr_create_path(path, xTo, yTo, spd, true))
    {
        target = noone;
        xTo = x;
        yTo = y;
    }
}
else
{
    if(distance_to_object(target) < 8)
    {
        instance_create(target.x+16, target.y+16, obj_egg);
        state = states.idle;
        target = noone;
        xTo = x;
        yTo = y;
    }
}
