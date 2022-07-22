/// destroy_encounterManager

with(obj_encounterManager)
{
    ds_list_destroy(enemies);
    ds_list_destroy(turnList);
    instance_destroy();
}
