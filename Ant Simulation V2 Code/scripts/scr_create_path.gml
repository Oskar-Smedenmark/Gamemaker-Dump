///scr_create_path(path, xTo, yTo, speed, allowDiag)

if(mp_grid_path(global.grid, argument0, x, y, argument1, argument2, argument4))
{
    path_start(argument0, argument3, path_action_stop, false);
    return true;
}
else
{
    return false;
}
