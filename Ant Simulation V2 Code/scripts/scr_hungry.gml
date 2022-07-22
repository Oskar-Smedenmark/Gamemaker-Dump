///scr_hungry()

if(target == noone)
{
    if(!ds_list_empty(obj_world_controller.eatableFood))
    {
        var randFood = ds_list_find_value(obj_world_controller.eatableFood, irandom(ds_list_size(obj_world_controller.eatableFood)-1));
        target = randFood;
        //Create a path to the target
        if(!scr_create_path(path, target.foodArea.x+16, target.foodArea.y+16, spd, false))
        {
            return scr_reset_state(false, "HUNGRY: No path to target");
        }
    }
    else
    {
        return scr_reset_state(false, "HUNGRY: No available food sources");
    }
}
if(instance_exists(target))
{
    if(distance_to_object(target) <= edDistance)
    {
        hungerIncCounter -= 1 / global.gameSpeed;
        if(hungerIncCounter <= 0)
        {
            hungerIncCounter = hungerIncTime;
            hunger++;
            with(target)
            {
                food--;
                part_particles_create(obj_ps.ps_blood, x+16, y+16, obj_ps.part_blood, 1);
            }
            if(hunger >= hungerMax)
            {
                hunger = hungerMax;
                return scr_reset_state(true, "HUNGRY: Done eating");
            }
        }
    }
}
else
{
    return scr_reset_state(false, "HUNGRY: My Target doesn't exist");
}
