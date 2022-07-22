/// no_more_armor(target)
var currentTarget = argument0;
with(currentTarget)
{
    var amountOfDifferentArmors = 0;
    for(var i = 0; i < elements_size(); i++)
    {
        if(armor[i] > 0)
        {
            amountOfDifferentArmors++;
        }
    }
    if(amountOfDifferentArmors > 0)
    {
        return amountOfDifferentArmors;
    }
}
return -1;
