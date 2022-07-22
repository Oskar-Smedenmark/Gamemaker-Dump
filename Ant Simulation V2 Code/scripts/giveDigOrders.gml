///giveDigOrders()
//If there is orders
if(!ds_list_empty(digOrders))
{
    //Go through the list
    for(var i = 0; i < ds_list_size(digOrders); i++)
    {
        var order = ds_list_find_value(digOrders, i);
        var foundAnt = noone;
        var antOnOrder = false;
        //Check if someone is carrying this order out
        with(obj_worker)
        {
            if(target == order)
            {
                antOnOrder = true;
                break;
            }
        }
        if(!antOnOrder)
        {
            //Find an idle ant
            with(obj_worker)
            {
                if(state == states.idle)
                {
                    foundAnt = id;
                    break;
                }
            }
            //Is there an idle ant available
            if(foundAnt != noone)
            {
                if(instance_exists(order))
                {
                    with(foundAnt)
                    {
                        //Find closest open spot
                        var closest = scr_closest_opening(order);
                        if(closest != noone)
                        {
                            //If there is more dig targets than the newest one
                            with(obj_dig_target)
                            {
                                if(owner == foundAnt.id)
                                {
                                    instance_destroy();
                                }
                            }
                            closest.owner = id;
                            closest.digOrder = order;
                            //Check if there is a viable path to the dig target
                            if(scr_create_path(path, closest.x, closest.y, 0, false))
                            {
                                state = states.dig;
                                target = order;
                            }
                            else
                            {
                                with(closest)
                                {
                                    instance_destroy();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
