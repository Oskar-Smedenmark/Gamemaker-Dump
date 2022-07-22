///scr_bug_idle()
if(target == noone)
{
    var rX = alignToGrid(irandom_range(x - idleRange, x + idleRange));
    var rY = alignToGrid(irandom_range(y - idleRange, y + idleRange));
    if(!scr_hit_non_walkable(rX, rY))
    {
        target = instance_create(rX, rY, obj_bug_idle_target);
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
    if(distance_to_object(target) < 8)
    {
        with(target)
        {
            instance_destroy();
        }
        target = noone;
    }
}
digCounter--;
if(digCounter <= 0)
{
    with(target)
    {
        instance_destroy();
    }
    target = noone;
    digCounter = digTime;
    state = states.dig;
}
