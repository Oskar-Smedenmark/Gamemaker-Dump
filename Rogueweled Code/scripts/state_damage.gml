/// state_damage
with(obj_matrixManager)
{
    damageCounter--;
    if(damageCounter <= 0)
    {
        damageCounter = damageTime;    
        if(no_more_damage(obj_hero) || is_fight_over())
        {
            if(is_turn_over())
            {
                if(swaps < maxSwaps)
                {
                    change_state(State.move);
                }
                else
                {
                    swaps = 0;
                    obj_hero.myTurn = false;
                    change_state(State.waitForTurn);
                }
            }
        }
        else
        {
            var kills = 0;
            var curDamage = 0;
            var attacksSpawned = 0;
            var elementsUsed = 0;
            for(var i = 0; i < elements_size(); i++)
            {
                var attacksToSpawn = floor(obj_hero.damage[i]/3);
                if(attacksToSpawn >= 1)
                {
                    elementsUsed++;
                }
                for(var j = 0; j < attacksToSpawn; j++)
                {
                    var nextEnemey = target;
                    if(nextEnemey != noone && instance_exists(target))
                    {
                        attack_target(obj_hero.x, obj_hero.y, nextEnemey, 3, 3*elementsUsed*room_speed*attackSpeed + j*room_speed*attackSpeed,get_element_with_index(i));
                        curDamage += 3;
                        attacksSpawned++;
                    }
                    else
                    {
                        j--;
                        target = get_next_enemy(0);
                        if(target == noone)
                        {
                            break;
                        }
                    }
                }
                if(obj_hero.damage[i]%3 != 0)
                {
                    var nextEnemey = target;
                    if(nextEnemey != noone)
                    {
                        if(!instance_exists(nextEnemey))
                        {
                            nextEnemey = get_next_enemy(0);
                        }
                        if(!is_fight_over())
                        {
                            attack_target(obj_hero.x, obj_hero.y, nextEnemey, obj_hero.damage[i]%3, i*room_speed*attackSpeed + attacksToSpawn*room_speed*attackSpeed,get_element_with_index(i));
                            curDamage += obj_hero.damage[i]%3;
                            attacksSpawned++;
                        }
                    }
                    else
                    {
                        nextEnemey = get_next_enemy(0);
                        if(!is_fight_over())
                        {
                            attack_target(obj_hero.x, obj_hero.y, nextEnemey, obj_hero.damage[i]%3, i*room_speed*attackSpeed + attacksToSpawn*room_speed*attackSpeed,get_element_with_index(i));
                            curDamage += obj_hero.damage[i]%3;
                            attacksSpawned++;
                        }
                    }
                }
                obj_hero.damage[i] = 0;
            }
        }
    }
}
