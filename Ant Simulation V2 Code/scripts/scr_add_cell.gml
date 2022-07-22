///scr_add_cell(x, y)
//Adds a cell to the grid and updates the paths of ants
mp_grid_add_cell(global.grid, argument[0], argument[1]);
obj_world_controller.solidGrid[# argument[0], argument[1]] = -1;
scr_update_paths();
