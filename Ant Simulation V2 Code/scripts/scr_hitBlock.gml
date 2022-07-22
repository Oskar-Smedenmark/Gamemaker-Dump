///scr_hitBlock(x,y)
var xx = argument[0];
var yy = argument[1];
//Check if the coordinate hit one of the following blocks
//Solid, water, food, nest area
return position_meeting(xx, yy, obj_solid) || position_meeting(xx, yy, obj_water) || position_meeting(xx, yy, obj_food) || position_meeting(xx, yy, obj_nest_area);
