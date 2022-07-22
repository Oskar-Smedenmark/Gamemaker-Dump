/// move_possible()
var numbOfIterations = 0;
with(obj_matrixManager)
{
    var eles = ds_list_create();
    var isPossible = false;
    while(!isPossible)
    {
        numbOfIterations++;
        for(var i = 0; i < elements_size(); i++)
        {
            ds_list_add(eles, 0);
        }
        for(var i = 0; i < width && !isPossible; i++)
        {
            for(var j = 0; j < height && !isPossible; j++)
            {
                var swapped = false;
                var curGem = gemGrid[# i,j];
                if(curGem.gType != Types.blank)
                {
                    for(var n = clamp(curGem.gridPosX - 1,0,width-1); n <= clamp(curGem.gridPosX + 1,0,width-1) && !isPossible; n++)
                    {
                        for(var m = clamp(curGem.gridPosY - 1,0,height-1); m <= clamp(curGem.gridPosY + 1,0,height-1) && !isPossible; m++)
                        {
                            var swapGem = gemGrid[# n, m];
                            if(swapGem.gType != Types.blank)
                            {
                                gemGrid[# curGem.gridPosX, curGem.gridPosY] = swapGem;
                                gemGrid[# swapGem.gridPosX, swapGem.gridPosY] = curGem;
                                var adjGems = gem_adj_list();
                                gemGrid[# curGem.gridPosX, curGem.gridPosY] = curGem;
                                gemGrid[# swapGem.gridPosX, swapGem.gridPosY] = swapGem;
                                if(!ds_list_empty(adjGems))
                                {
                                    isPossible = true;
                                    for(var ii = 0; ii < ds_list_size(adjGems); ii++)
                                    {
                                        var g = ds_list_find_value(adjGems, ii);
                                        with(g)
                                        {
                                            highlightDEBUG = true;
                                        }
                                    }
                                }
                                ds_list_destroy(adjGems);
                            }
                        }
                    }
                    
                }
            }
        }
        if(!isPossible)
        {
            var sX = xStart;
            var sY = yStart;
            var oSet = offset;
            for(var i = 0; i < width; i++)
            {
                for(var j = 0; j < height; j++)
                {
                    with(gemGrid[# i,j])
                    {
                        var blankGem = create_gem(sX + gridPosX*oSet, sY + gridPosY*oSet, obj_gem_blank, Element.white);
                        obj_matrixManager.gemGrid[# i,j] = blankGem;
                        blankGem.gridPosX = i;
                        blankGem.gridPosY = j;
                        instance_destroy();
                    }
                }
            }
            for(var i = 0; i < width*height; i++)
            {
                spawn_gems();
                make_gems_fall();
            }
        }
        else
        {
            gem_update_highlight();
        }
        ds_list_clear(eles);
    }
    ds_list_destroy(eles);
}
show_debug_message("numbOfIterations = " + string(numbOfIterations));
