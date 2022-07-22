/// spawn_gems
with(obj_matrixManager)
{
    curSpawnPos++;
    if(curSpawnPos >= width)
    {
        curSpawnPos = 0;
    }
    var curGem = gemGrid[# curSpawnPos, 0];
    if(curGem.gType == Types.blank)
    {
        var obj_ind = get_next_gem();
        if(obj_ind == noone)
        {
            /*for(var i = 0; i < ds_list_size(gemInventory); i++)
            {
                ds_list_add(nextGemList, gemInventory[| i]);
            }
            ds_list_shuffle(nextGemList);
            obj_ind = get_next_gem();*/
            return true;
        }
        //obj_ind = obj_ind.object_index;
        instance_activate_object(obj_ind);
        var newlyCreatedGem = obj_ind;//create_gem(xStart + offset*curGem.gridPosX, yStart, obj_ind, get_element_with_index(irandom(6)));
        
        if(previewRowAmount != 0)
        {
            var createdGem = ds_list_find_value(ds_list_find_value(nextRows,0), curSpawnPos);
            createdGem.interactable = true;
            gemGrid[# curGem.gridPosX, curGem.gridPosY] = createdGem;
            createdGem.gridPosX = curGem.gridPosX;
            createdGem.gridPosY = curGem.gridPosY;
            for(var i = 0; i < previewRowAmount - 1; i++)
            {
                ds_list_set(ds_list_find_value(nextRows, i), curSpawnPos, ds_list_find_value(ds_list_find_value(nextRows,i + 1),curSpawnPos));
                var fallingGem = ds_list_find_value(ds_list_find_value(nextRows, i), curSpawnPos);
                fallingGem.gridPosY++;
            }
            ds_list_set(nextRows[| previewRowAmount-1], curSpawnPos, newlyCreatedGem);
            newlyCreatedGem.y -= offset*previewRowAmount;
            newlyCreatedGem.gridPosX = curGem.gridPosX;
            newlyCreatedGem.gridPosY = -previewRowAmount;
            newlyCreatedGem.interactable = false;
        }
        else
        {
            newlyCreatedGem.y -= offset;
            newlyCreatedGem.gridPosX = curGem.gridPosX;
            newlyCreatedGem.gridPosY = curGem.gridPosY;
            gemGrid[# curGem.gridPosX, curGem.gridPosY] = newlyCreatedGem;
        }
        //nextRows[| previewRowAmount-1][| curSpawnPos] = create_gem(xStart + offset*curGem.gridPosX, yStart -offset*(previewRowAmount+1), obj_ind);
        //nextRows[| previewRowAmount-1][| curSpawnPos].gridPosX = curGem.gridPosX;
        //nextRows[| previewRowAmount-1][| curSpawnPos].gridPosY = -previewRowAmount;
        
        //var nextGem = nextRow[| curSpawnPos];
        //nextGem.gridPosY = -1;
        //nextGem.interactable = false;
        instance_destroy(curGem);
    }
}
return false;
