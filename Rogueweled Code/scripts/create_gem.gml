/// create_gem(x, y, obj_gem, element)
var tempX = argument0, tempY = argument1, tempGem = argument2, tempEle = argument3;

var tempGridX = x_to_gridX(tempX);
var tempGridY = y_to_gridY(tempY);
    with(obj_matrixManager)
    {
        var currentGem = instance_create( tempGridX*offset + xStart, tempGridY*offset + yStart, tempGem);
        currentGem.gElement = tempEle;
        currentGem.image_index = get_index_with_element(tempEle);
        return currentGem;
    }
return noone;
