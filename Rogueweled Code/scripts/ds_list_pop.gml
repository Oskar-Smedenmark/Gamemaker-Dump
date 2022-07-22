/// ds_list_pop(list)
var currentList = argument0;
/// @returns {T} [List Value and removes it or noone if it can't]
if(ds_list_size(currentList) > 0)
{
    var currentValue = ds_list_find_value(currentList, 0);
    ds_list_delete(currentList, 0);
    return currentValue;
}
return noone;
