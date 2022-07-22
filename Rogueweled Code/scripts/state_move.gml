/// state_move
with(obj_matrixManager)
{
    if(mouse_check_button_pressed(mb_left))
    {
        if(instance_position(mouse_x, mouse_y, par_enemy))
        {
            target = instance_position(mouse_x, mouse_y, par_enemy);
        }
        else
        {
            var gem = gemGrid[# x_to_gridX(mouse_x), y_to_gridY(mouse_y)];
            if(gem.interactable)
            {
                global.clickedGem = gem;
                gem.clicked = true;
            }
        }
    }
    if(mouse_check_button(mb_left))
    {
        var gem = gemGrid[# x_to_gridX(mouse_x), y_to_gridY(mouse_y)];
        if(global.clickedGem != noone && global.clickedGem != gem && gem.interactable)
        {
            var swapped = false;
            for(var i = clamp(gem.gridPosX - 1,0,width-1); i <= clamp(gem.gridPosX + 1,0,width-1) && !swapped; i++)
            {
                for(var j = clamp(gem.gridPosY - 1,0,height-1); j <= clamp(gem.gridPosY + 1,0,height-1) && !swapped; j++)
                {
                    if(global.clickedGem == gemGrid[# i, j])
                    {
                        gem.tempMove = true;
                        swapped = true;
                        var tempGX = gem.gridPosX;
                        var tempGY = gem.gridPosY;
                        gem.tempX = global.clickedGem.xTo;
                        gem.tempY = global.clickedGem.yTo;
                        gemGrid[# tempGX, tempGY] = global.clickedGem;
                        gemGrid[# global.clickedGem.gridPosX, global.clickedGem.gridPosY] = gem;
                        gem_update_highlight();
                        gemGrid[# tempGX, tempGY] = gem;
                        gemGrid[# global.clickedGem.gridPosX, global.clickedGem.gridPosY] = global.clickedGem;
                    }
                    var tempMoved = 1;
                    var prevGem = noone;
                    with(par_gem)
                    {
                        if(tempMove && gem != id)
                        {
                            tempMoved++;
                            prevGem = id;
                        }
                    }
                    if(tempMoved > 1)
                    {
                        prevGem.tempMove = false;
                    }
                }
            }
        }
        else if(global.clickedGem != noone)
        {
            gem_update_highlight();
            with(par_gem)
            {
                tempMove = false;
            }
        }
    }
    if(mouse_check_button_released(mb_left))
    {
        var gem = gemGrid[# x_to_gridX(mouse_x), y_to_gridY(mouse_y)];
        if(instance_exists(global.clickedGem))
        {
            global.clickedGem.clicked = false;
            global.clickedGem.image_angle = 0;
        
            if(gem != global.clickedGem && gem.interactable)
            {
                if(!gem.destroyed && !global.clickedGem.destroyed)
                {
                    var swapped = false;
                    for(var i = clamp(gem.gridPosX - 1,0,width-1); i <= clamp(gem.gridPosX + 1,0,width-1) && !swapped; i++)
                    {
                        for(var j = clamp(gem.gridPosY - 1,0,height-1); j <= clamp(gem.gridPosY + 1,0,height-1) && !swapped; j++)
                        {
                            if(global.clickedGem.id == gemGrid[# i, j].id)
                            {
                                swapped = true;
                                swaps++;
                                gemGrid[# gem.gridPosX, gem.gridPosY] = global.clickedGem;
                                gemGrid[# global.clickedGem.gridPosX, global.clickedGem.gridPosY] = gem;
                                var tempGX = gem.gridPosX;
                                var tempGY = gem.gridPosY;
                                gem.gridPosX = global.clickedGem.gridPosX;
                                gem.gridPosY = global.clickedGem.gridPosY;
                                global.clickedGem.gridPosX = tempGX;
                                global.clickedGem.gridPosY = tempGY;
                                change_state(State.destroy);
                            }
                        }
                    }
                }
            }
        }
        global.clickedGem = noone;
        gem_update_highlight();
        with(par_gem)
        {
            tempMove = false;
        }
    }
}
