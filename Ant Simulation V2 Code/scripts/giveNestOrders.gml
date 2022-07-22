///giveNestOrders()
//If there is orders
if(!ds_list_empty(nestOrders))
{
    //Go through the list
    for(var i = 0; i < ds_list_size(nestOrders); i++)
    {
        var order = ds_list_find_value(nestOrders, i);
        if(order != noone)
        {
            var foundAnt = noone;
            var antOnOrder = false;
            with(obj_worker)
            {
                if(target == order)
                {
                    antOnOrder = true;
                    break;
                }
            }
            //Check if someone is carrying this order out
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
                            //Check if there is a path to the target
                            if(scr_create_path(path, order.x, order.y, 0, false))
                            {
                                state = states.createNest;
                                target = order;
                                order.owner = id;
                            }
                        }
                    }
                }
            }
        }
        else
        {
            ds_list_delete(nestOrders, i);
        }
    }
}
