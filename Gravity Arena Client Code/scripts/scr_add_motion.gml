///scr_add_motion(dir, speed)
var theDirection = argument0;
var theSpeed = argument1;

hspd += theSpeed*cos(pi/180*theDirection);
vspd -= theSpeed*sin(pi/180*theDirection);
