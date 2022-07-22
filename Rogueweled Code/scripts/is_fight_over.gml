/// is_fight_over()

with(obj_encounterManager)
{
    return ds_list_size(turnList) <= 1;
}
