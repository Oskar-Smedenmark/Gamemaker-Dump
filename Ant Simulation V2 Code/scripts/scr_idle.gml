///scr_idle()
//Checks if ant got a target and there is enough nest area for the amount of ants
if((target == noone || target.object_index != obj_target) && global.amountOfAnts/ds_list_size(obj_world_controller.nestAreas) <= obj_world_controller.antsPerNestArea)
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
statusFailedCounter--;
//Are you hungry? If you are change state
if(hunger <= hungerLimit && statusFailedCounter <= 0)
{
    statusFailedCounter = statusFailedTime;
    if(!ds_list_empty(obj_world_controller.eatableFood))
    {
        state = states.hungry;
        target = noone;
        xTo = x;
        yTo = y;
    }
    else
    {
        statusFailedCounter = 0;
    }
}
if(target != noone)
{
    if(distance_to_object(target) <= TILE_WIDTH/2)
    {
        if(target.object_index == obj_target)
        {
            with(target)
            {
                instance_destroy();
            }
        }   
        scr_reset_state(true, "IDLE: GOT TO TARGET");
    }
}
//Are you Thirsty? If you are change state
if(thirst <= thirstLimit && statusFailedCounter <= 0)
{
    statusFailedCounter = statusFailedTime;
    if(instance_exists(obj_water))
    {
        state = states.thirsty;
        target = noone;
        xTo = x;
        yTo = y;
    }
}
lookForEnemies();
if(isScout)
{
  state = states.scout;  
}
