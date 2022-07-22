///create_generation()

var matingpool = ds_list_create();
var nextIndex = 0;

for(var i = 0; i < ds_list_size(currDirections) - 1; i++)
{
    currFitness = ds_list_find_value(lastGenerationFitness, i);
    var n = floor(currFitness * 100);
    for(var j = 0; j < n; j++)
    {
        ds_list_add(matingpool, ds_list_find_value(currDirections, i));
        ds_list_mark_as_list(matingpool, ds_list_size(matingpool)-1);
    }
}

var parentA = ds_list_create();
var parentB = ds_list_create();
var child = ds_list_create();
for(var i = ds_list_size(currDirections); i > 0; i--)
{
    ds_list_delete(currDirections, 0);
}
for(var j = 0; j < nrOfMissiles; j++)
{
    var theRandomNumber = irandom(ds_list_size(matingpool)-1);
    ds_list_add(parentA, ds_list_find_value(matingpool, theRandomNumber));
    ds_list_add(parentB, ds_list_find_value(matingpool, theRandomNumber));
    var parentBDirs = ds_list_find_value(parentB, 0);
    var parentADirs = ds_list_find_value(parentA, 0);
    var nrOfIdenticals = nrOfDirections;
    while(nrOfIdenticals == nrOfDirections)
    {
        ds_list_insert(parentB, 0, ds_list_find_value(matingpool, irandom(ds_list_size(matingpool)-1)));
        parentBDirs = ds_list_find_value(parentB, 0);
        nrOfIdenticals = 0;
        for(var i = 0; i < ds_list_size(parentBDirs); i++)
        {
            if(ds_list_find_value(parentBDirs, i) == ds_list_find_value(parentADirs, i))
            {
                nrOfIdenticals++;
            }
        }
    }
    crossover(parentA, parentB, child);
    currMissile = instance_create(room_width/2, room_height - 100, obj_missile);
    init_missile(child, currMissile);
    ds_list_add(currDirections, currMissile.myDirections);
    ds_list_mark_as_list(currDirections, j);
    ds_list_add(newMissiles, currMissile.id);
    for(var i = 0; i < nrOfDirections; i++)
    {
        ds_list_delete(child, 0);
    }
    ds_list_delete(parentA, 0);
    ds_list_delete(parentB, 0);
}
ds_list_destroy(parentA);
ds_list_destroy(parentB);
ds_list_destroy(child);
ds_list_destroy(matingpool);
