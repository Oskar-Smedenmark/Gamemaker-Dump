///scr_collect()
if(target == noone)
{
    return scr_reset_state(false, "COLLECTING: I have no target");
}
else
{
    if(instance_exists(target))
    {   
        if(distance_to_object(target) < carryRange)
        {
            readyToCarry = true;
            if(target.carried && !goingToTarget)
            {
                if(!scr_create_path(path, target.foodAreaX + 16, target.foodAreaY + 16, spd, true))
                {
                    return scr_reset_state(false, "COLLECTING: Can't find path to food area");
                }
                goingToTarget = true;
            }
        }
        else if(!target.carried)
        {
            if(!scr_create_path(path, target.x + 16, target.y + 16, spd, true))
            {
                return scr_reset_state(false,"COLLECTING: Can't find path to target");
            }
        }
        if(instance_exists(target))
        {
            if(target.inFoodPile) //distance_to_object(target.foodArea) <= carryRange)
            {
                return scr_reset_state(true, "COLLECTING: Target is in food pile");
            }
        }
        else
        {
            return scr_reset_state(false, "COLLECTING: Tried to leave target in food pile but target doesn't exist");
        }
    }
    else
    {
        return scr_reset_state(false, "COLLECTING: Instance doesn't exist");
    }
}
