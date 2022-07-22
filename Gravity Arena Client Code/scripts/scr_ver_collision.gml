///scr_ver_collision(objectToCollideWith, speed)
var object = argument0;
var theSpd = argument1;
var collision = false;

if(place_meeting(x, y + theSpd, object))
{
    while(!place_meeting(x, y + sign(theSpd), object))
    {
        y += sign(theSpd);
    }
    vspd = 0;
    collision = true;
}
return collision;
