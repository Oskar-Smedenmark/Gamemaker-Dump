/// gem_adj_list
var checkedGems = ds_list_create();
var returnGems = ds_list_create();
for(var i = 0; i < width; i++)
{
    for(var j = 0; j < height; j++)
    {
        var curGem = gemGrid[# i, j];
        var gemsInARow = 0;
        var gemsInACol = 0;
        if(curGem.gType != Types.blank)
        {
            //for every gem, check row and column
            for(var n = i+1; n < width; n++)
            {
                var nextGem = gemGrid[# n, j];
                if(nextGem.gElement == curGem.gElement){
                    gemsInARow++;
                    ds_list_add(checkedGems, nextGem);
                }
                else{
                    break;
                }
            }
            for(var n = i-1; n >= 0; n--)
            {
                var nextGem = gemGrid[# n, j];
                if(nextGem.gElement == curGem.gElement){
                    gemsInARow++;
                    ds_list_add(checkedGems, nextGem);
                }
                else{
                    break;
                }
            }
            if(gemsInARow >= 2)
            {
                ds_list_add(checkedGems, curGem);
                for(var n = 0; n < ds_list_size(checkedGems); n++)
                {
                    var gem = ds_list_find_value(checkedGems, n);
                    if(ds_list_find_index(returnGems, gem) == -1)
                    {
                        ds_list_add(returnGems,gem);
                    }
                }
            }
            else
            {
                ds_list_clear(checkedGems);   
                gemsInARow = 0;
            }
            
            for(var n = j+1; n < height; n++)
            {
                var nextGem = gemGrid[# i, n];
                if(nextGem.gElement == curGem.gElement){
                    gemsInACol++;
                    ds_list_add(checkedGems, nextGem);
                }
                else{
                    break;
                }
            }
            for(var n = j-1; n >= 0; n--)
            {
                var nextGem = gemGrid[# i, n];
                if(nextGem.gElement == curGem.gElement){
                    gemsInACol++;
                    ds_list_add(checkedGems, nextGem);
                }
                else{
                    break;
                }
            }
            if(gemsInACol >= 2)
            {
                ds_list_add(checkedGems, curGem);
                for(var n = 0; n < ds_list_size(checkedGems); n++)
                {
                    var gem = ds_list_find_value(checkedGems, n);
                    if(ds_list_find_index(returnGems, gem) == -1)
                    {
                        ds_list_add(returnGems,gem);
                    }
                }
            }
            else
            {
                var startSize = ds_list_size(checkedGems);
                for(var n = startSize-1; n >= gemsInARow; n--)
                {
                    ds_list_delete(checkedGems, n);
                }
                gemsInACol = 0;
            }
            if(gemsInARow >= 2 || gemsInACol >= 2)
            {
                var initSize = ds_list_size(checkedGems);
                for(var n = 0; n < initSize; n++)
                {
                    var gem = ds_list_pop(checkedGems);
                    if(gem != noone)
                    {
                        if(ds_list_find_index(returnGems, gem) != -1)
                        {
                            var curMatchSize = (gemsInACol) + (gemsInARow) - 2; 
                            if(curMatchSize > gem.matchSize)
                            {
                                gem.matchSize = curMatchSize;
                            }
                        }
                    }
                    else
                    {
                        show_debug_message("Gem is noone at end of gem_adj_list()!");
                    }
                }
            }
            //ds_list_clear(checkedGems);
        }
    }
}
ds_list_destroy(checkedGems);
return returnGems;
