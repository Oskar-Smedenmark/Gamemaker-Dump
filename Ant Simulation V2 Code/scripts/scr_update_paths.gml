///scr_update_paths()
//Updates the path of ants who aren't idle or digging
/*with(obj_ant)
{
    if(target != noone && state != states.idle && state != states.dig)
    {
        var unblocked = scr_create_path(path, xTo, yTo, spd, true);
        if(!unblocked)
        {
            path_end();
            state = states.idle;
            target = noone;
        }
    }
}
