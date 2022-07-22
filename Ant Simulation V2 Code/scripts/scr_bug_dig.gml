///scr_bug_dig()
if(!instance_exists(target) && target != noone)
{
    with(digTarget)
    {
        instance_destroy();
    }
    return scr_reset_state(false, "BUG_DIG: Target doesn't exist but I have a target");
}
if(target == noone)
{
    target = instance_nearest(x, y, obj_solid);
    if(!instance_exists(target))
    {
        return scr_reset_state(false, "BUG_DIG: Target doesn't exist but I just got it");
    }
    digTarget = scr_closest_opening(target);
    if(instance_exists(digTarget))
    {
        digTarget.digTarget = target;
        digTarget.owner = id;
        if(!scr_create_path(path, digTarget.x, digTarget.y, spd, false))
        {
            with(digTarget)
            {
                instance_destroy();
            }
            return scr_reset_state(false, "BUG_DIG: No available path to target");
        }
    }
    else
    {
        with(digTarget)
        {
            instance_destroy();
        }
    }
}
else
{
    if(distance_to_object(target) <= 64)
    {   
        scr_remove_cell(target.x div TILE_WIDTH + global.offsetX, target.y div TILE_HEIGHT + global.offsetY);
        with(target)
        {
            instance_destroy();
        }
        var placePosX = x + lengthdir_x(TILE_WIDTH, irandom(360));
        var placePosY = y + lengthdir_y(TILE_HEIGHT, irandom(360));
        while(instance_position(placePosX, placePosY, obj_solid) != noone)
        {
            placePosX = x + lengthdir_x(TILE_WIDTH, irandom(360));
            placePosY = y + lengthdir_y(TILE_HEIGHT, irandom(360));
        }
        instance_create(placePosX div TILE_WIDTH * TILE_WIDTH + global.offsetX, placePosY div TILE_HEIGHT * TILE_HEIGHT + global.offsetY, obj_solid);
        scr_add_cell(placePosX div TILE_WIDTH + global.offsetX, placePosY div TILE_HEIGHT + global.offsetY);
        
        return scr_reset_state(true, "BUG_DIG: Target have been dug");
    }
}
