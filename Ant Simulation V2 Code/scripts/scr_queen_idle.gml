///scr_queen_idle()
//Checks if ant got a target and there is enough nest area for the amount of ants
if(target == noone && global.amountOfAnts/ds_list_size(obj_world_controller.nestAreas) <= obj_world_controller.antsPerNestArea)
{
    //Get a random index from all of the nest areas
    var ind = irandom(ds_list_size(obj_world_controller.nestAreas)-1);
    var area = ds_list_find_value(obj_world_controller.nestAreas, ind);
    target = instance_create(area.x, area.y, obj_target);
    target.owner = id;
    xTo = target.x + 16;
    yTo = target.y + 16;
    //Create a path to the target
    if(!scr_create_path(path, xTo, yTo, spd, true))
    {
        with(target)
        {
            instance_destroy();
        }
        target = noone;
        xTo = x;
        yTo = y;
    }
}
if(target != noone)
{
    if(distance_to_object(target) <= TILE_WIDTH/2)
    {
         with(target)
        {
            instance_destroy();
        }
        target = noone;
    }
}
//Are you hungry? If you are change state
if(hunger <= hungerLimit)
{
    if(instance_exists(obj_food))
    {
        state = states.hungry;
        target = noone;
        xTo = x;
        yTo = y;
    }
}
//Are you Thirsty? If you are change state
if(thirst <= thirstLimit)
{
    if(instance_exists(obj_water))
    {
        state = states.thirsty;
        target = noone;
        xTo = x;
        yTo = y;
    }
}

eggLayingCounter -= 1 / global.gameSpeed;
if(eggLayingCounter <= 0 && instance_exists(obj_nest_area))
{
    eggLayingCounter = eggLayingTime;
    state = states.layEgg;
    target = noone;
    xTo = x;
    yTo = y;
}
