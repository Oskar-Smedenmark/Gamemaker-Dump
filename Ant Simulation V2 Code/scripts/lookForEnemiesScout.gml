///lookForEnemiesScout()
var enemyNearby = collision_circle(x, y, detectionRange, obj_bug, false, false);
if(enemyNearby != noone)
{
    var enemySeen = collision_line(x,y, enemyNearby.x, enemyNearby.y, obj_solid, false, false);
    if(enemySeen == noone)
    {
        if(target != noone)
        {
            if(instance_exists(target))
            {
                if(target.object_index == obj_target)
                {
                    with(target)
                    {
                        instance_destroy();
                    }
                }   
            }
        }
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
        threat = enemyNearby;
        
        state = states.alert;
    }
}
