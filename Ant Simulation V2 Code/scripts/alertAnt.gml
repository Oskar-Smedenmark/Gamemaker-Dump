///alertAnt()
var xx = x;
var yy = y;
x = x + 1000000;
y = y + 1000000;


var ant = instance_nearest(xx,yy, obj_worker);

x = xx;
y = yy;
if(distance_to_object(ant) < TILE_WIDTH)
{
    if(ant.state == states.idle)
    {
        ant.state = states.attack;
        ant.target = threat;
    }
}

if(distance_to_object(target) <= TILE_WIDTH/2)
{
    if(target.object_index == obj_target)
    {
        with(target)
        {
            instance_destroy();
        }
    }
    scr_reset_state(true, "ALERT ANT: GOT TO TARGET");
}
