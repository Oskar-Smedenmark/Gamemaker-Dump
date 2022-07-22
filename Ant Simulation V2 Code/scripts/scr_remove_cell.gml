///scr_remove_cell(x, y)
//Removes a cell from the grid and updates the paths of ants
mp_grid_clear_cell(global.grid, argument[0], argument[1]);
obj_world_controller.solidGrid[# argument[0], argument[1]] = 0;
scr_update_paths();
