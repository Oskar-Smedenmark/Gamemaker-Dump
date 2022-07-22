/// deal_damage(damage, element, target)
var currentDamage = argument0, currentElement = argument1, currentTarget = argument2;
if(!is_fight_over())
{
    if(instance_exists(currentTarget))
    {
        var largestDamageValues = ds_list_create();
        var elementsOrder = ds_list_create();
        for(var i = 0; i < elements_size(); i++)
        {
            var curDamage = currentDamage*elements_strength(currentElement, get_element_with_index(i));
            var addedDamage = false;
            for(var j = 0; j < ds_list_size(largestDamageValues) || ds_list_size(largestDamageValues) == 0; j++)
            {
                if(ds_list_size(largestDamageValues) == 0 || curDamage > largestDamageValues[| j])
                {
                    addedDamage = true;
                    ds_list_insert(largestDamageValues, j, curDamage);
                    ds_list_insert(elementsOrder, j, get_element_with_index(i));
                    break;
                }
            }
            if(!addedDamage)
            {
                var idx = ds_list_size(largestDamageValues);
                ds_list_insert(largestDamageValues, idx, curDamage);
                ds_list_insert(elementsOrder, idx, get_element_with_index(i));
            }
        }
        var currentIndex = 0;
        while(no_more_armor(currentTarget) != -1 && currentDamage > 0)
        {
            var currElement = ds_list_pop(elementsOrder);
            var lastArmor = currentTarget.armor[get_index_with_element(currElement)];
            if(lastArmor > 0)
            {
                currentTarget.armor[get_index_with_element(currElement)] -= round(currentDamage*elements_strength(currentElement, currElement));
                var newArmor = currentTarget.armor[get_index_with_element(currElement)];
                if(newArmor < 0)
                {
                    currentTarget.armor[get_index_with_element(currElement)] = 0;
                    currentDamage = round(-newArmor/currentDamage*elements_strength(currentElement, currElement));
                }
                else
                {
                    currentDamage = 0;
                }
            }
        }
        ds_list_destroy(elementsOrder);
        ds_list_destroy(largestDamageValues);
        var lastHp = currentTarget.hp;
        currentTarget.hp -= currentDamage;
        currentDamage -= lastHp;
        if(currentDamage < 0)
        {
            currentDamage = 0;
        }
    }
}
return currentDamage;
