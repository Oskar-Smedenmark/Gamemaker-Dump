///scr_object_inside_area(x1, y1, x2, y2, object)
var x1 = argument[0];
var y1 = argument[1];
var x2 = argument[2];
var y2 = argument[3];
var obj = argument[4];

var objects = ds_list_create();

with(obj)
{
    if(collision_rectangle(x1,y1,x2,y2,id,false,false))
    {
        ds_list_add(objects, id);
    }
}

return objects;
