///scr_movement_new(up, down, left, right)
var up = argument0;
var down = argument1;
var left = argument2;
var right = argument3;

if(!stunned)
{
    if(up)
    {
        motion_add(90, acc * global.gameSpeed);
    }
    if(down)
    {
        motion_add(270, acc * global.gameSpeed);
    }
    if(left)
    {
        motion_add(180, acc * global.gameSpeed);
    }
    if(right)
    {
        motion_add(0, acc * global.gameSpeed);
    }
    
}
