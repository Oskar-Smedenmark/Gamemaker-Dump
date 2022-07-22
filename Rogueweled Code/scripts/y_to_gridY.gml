/// y_to_gridY(y)
var tempY = argument0;

with(obj_matrixManager)
{
    return clamp((tempY - yStart + offset/2) div offset, 0, height-1);
}
return -1;
