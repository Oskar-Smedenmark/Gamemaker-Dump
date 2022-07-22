///scr_scout()
if(target == noone)
{
    var rX = alignToGrid(irandom_range(x - scoutRange, x + scoutRange));
    var rY = alignToGrid(irandom_range(y - scoutRange, y + scoutRange));
    if(!scr_hit_non_walkable(rX, rY))
    {
        target = instance_create(rX, rY, obj_target);
        target.owner = id;
        if(!scr_create_path(path, target.x, target.y, spd, true))
        {
            with(target)
            {
                instance_destroy();
            }
            target = noone;
        }
    }
}
else
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
        target = noone;
    }   
}
statusFailedCounter--;
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
lookForEnemiesScout();
