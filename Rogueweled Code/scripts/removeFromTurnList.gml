/// removeFromTurnList(id)
var toRemove = argument0;
with(obj_encounterManager)
{
    var removeIndex = ds_list_find_index(turnList, toRemove);
    ds_list_delete(turnList, removeIndex);
    if(removeIndex == turnPos)
    {
        increaseTurnPos();
    }
    
}
