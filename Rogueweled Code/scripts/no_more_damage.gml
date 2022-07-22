/// no_more_damage(target)
var currentTarget = argument0;
with(currentTarget)
{
    for(var i = 0; i < elements_size(); i++)
    {
        if(damage[i] != 0)
        {
            return false;
        }
    }
}
return true;
