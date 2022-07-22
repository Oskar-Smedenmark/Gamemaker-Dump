/// x_to_gridX(x)
var tempX = argument0;

with(obj_matrixManager)
{
    return clamp(((tempX - xStart + offset/2)) div offset, 0, width-1);
}
return -1;
