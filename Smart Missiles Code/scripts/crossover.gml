///crossover(parentA, parentB, child)
var newDirections = ds_list_create();
var mid = irandom(nrOfDirections - 1);
var parent0 = argument0;
var parent1 = argument1;
var theChild = argument2;
var parent0Dir = ds_list_find_value(parent0, 0);
var parent1Dir = ds_list_find_value(parent1, 0);
for(var m = 0; m < ds_list_size(ds_list_find_value(parent0, 0)); m++)
{
    if(m < mid)
    {
        ds_list_insert(newDirections, m, ds_list_find_value(parent0Dir, m));
    }
    else
    {
        ds_list_insert(newDirections, m, ds_list_find_value(parent1Dir, m));
    }
}
var mutation = irandom(99); //0 - 99
if(mutationChance >= mutation)
{
    for(var m = 0; m < nrOfDirections; m++)
    {
        ds_list_delete(newDirections, 0);
    }
    for(var m = 0; m < nrOfDirections; m++)
    {
        ds_list_add(newDirections, random(dirDegrees));
    }
    
}
for(var i = 0; i < ds_list_size(newDirections); i++)
{
    ds_list_add(theChild, ds_list_find_value(newDirections, i));
}

ds_list_destroy(newDirections);
