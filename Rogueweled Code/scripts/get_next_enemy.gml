/// get_next_enemy(offset)
var currentOffset = argument0;

with(obj_encounterManager)
{
    if(turnPos+currentOffset+1 < ds_list_size(turnList))
    {
        return turnList[|turnPos+currentOffset+1];
    }
    return noone;
}
