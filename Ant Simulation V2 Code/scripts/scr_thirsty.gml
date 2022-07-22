///scr_thirsty()
//If you don't have a target
if(target == noone)
{
    if(!ds_list_empty(obj_world_controller.drinkingWater))
    {
        var ind = irandom(ds_list_size(obj_world_controller.drinkingWater)-1);
        var watObj = ds_list_find_value(obj_world_controller.drinkingWater, ind);
        target = watObj;
        xTo = target.x + 16;
        yTo = target.y + 16;
        //Create a path to the target
        if(!scr_create_path(path, xTo, yTo, spd, true))
        {
            target = noone;
            xTo = x;
            yTo = y;
            return scr_reset_state(false, "THIRSTY: No path to water source");
        }
    }
    else
    {
        return scr_reset_state(false, "THIRSTY: No drinking water available");
    }   
}
else
{
    //Are you close enough to the water object
    if(distance_to_object(target) <= edDistance)
    {
        waterIncCounter -= 1 / global.gameSpeed;
        //Increase thirst
        if(waterIncCounter <= 0)
        {
            waterIncCounter = waterIncTime;
            thirst++;
            //Done drinking
            if(thirst >= thirstMax)
            {
                thirst = thirstMax;
                statusFailedCounter = statusFailedTime;
                return scr_reset_state(true, "THIRSTY: Finished drinking");
            }
        }
    }
}
