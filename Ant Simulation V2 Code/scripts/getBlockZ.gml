///getBlockZ(z)
var zz = argument0;

var dirtDensity = 50;

var block = noone;

if(zz <= dirtDensity)
{
    block = obj_solid;
}
else
{
    block = noone;
}
if(zz < 28 || zz > 80)
{
    block = obj_water;
}

return block;
