///giveCollectOrders()
//If there is orders
if(!ds_list_empty(collectOrders))
{
    //Go through the list
    for(var i = 0; i < ds_list_size(collectOrders); i++)
    {
        var order = ds_list_find_value(collectOrders, i);
        if(order != noone)
        {
            var antsOnOrder = 0;
            with(order)
            {
                antsOnOrder = ds_list_size(antsCarrying);
            }
            var antsNeeded = order.weight - antsOnOrder;
            //Check if enough ants is carrying out this order
            if(antsNeeded > 0)
            {
                var curAnt = noone;
                for(var j = 0; j < antsNeeded; j++)
                {
                    //Find an idle ant
                    with(obj_worker)
                    {
                        if(state == states.idle)
                        {
                            curAnt = id;
                            break;
                        }
                    }
                    //Is there an idle ant available
                    if(curAnt != noone)
                    {
                        if(instance_exists(order))
                        {
                            with(curAnt)
                            {
                                //Check if there is a path to the target
                                if(scr_create_path(path, order.x, order.y, 0, false))
                                {
                                    state = states.collect;
                                    target = order;
                                }
                                else
                                {
                                    with(order)
                                    {
                                        for(var k = 0; k < ds_list_size(antsCarrying); k++)
                                        {
                                            var antInList = antsCarrying[| k];
                                            with(antInList)
                                            {
                                                scr_reset_state(false, "COLLECT ORDER: Apparently I couldn't reach my target");
                                            }
                                        }
                                        ds_list_empty(antsCarrying);
                                    }
                                }
                            }
                            if(curAnt.state == states.collect)
                            {
                                with(order)
                                {
                                    ds_list_add(antsCarrying, curAnt);
                                }
                            }
                        }
                    }
                    curAnt = noone;
                }
            }
            else
            {
                ds_list_delete(collectOrders, i);
            }
        }
        /*else
        {
            ds_list_delete(collectOrders, i);
        }*/
    }
}
