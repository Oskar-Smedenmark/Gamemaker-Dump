///scr_hor_collision(objectToCollideWith, speed)
var object = argument0;
var theSpd = argument1;
var collision = false;
if(place_meeting(x + theSpd, y, object))
{
    while(!place_meeting(x + sign(theSpd), y, object))
    {
        x += sign(theSpd);
    }
    hspd = 0;
    collision = true;
}
return collision;
