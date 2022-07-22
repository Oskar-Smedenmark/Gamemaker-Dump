/// gem_update_highlight
var adjGems = gem_adj_list();
for(var i = 0; i < ds_list_size(adjGems); i++)
{
    var currentGem = ds_list_find_value(adjGems, i);
    currentGem.highlight = true;
}
with(par_gem)
{
    if(highlight)
    {
        if(ds_list_find_index(adjGems, id) == -1) highlight = false;
    }
}
ds_list_destroy(adjGems);
