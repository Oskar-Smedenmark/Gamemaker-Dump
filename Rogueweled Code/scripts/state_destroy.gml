/// state_destroy
with(obj_matrixManager)
{
    if(!spawnGems)
    {
        var checkedGems = gem_adj_list();
        for(var i = 0; i < ds_list_size(checkedGems); i++)
        {
            var currentGem = ds_list_find_value(checkedGems, i);
            currentGem.destroyed = true;
            spawnGems = true;
            destroyed = true;
        }
        ds_list_destroy(checkedGems);
        gem_update_highlight();
        if(/*!instance_exists(obj_gem_blank) && */!destroyed)
        {
            change_state(State.damage);
        }
    }
}
