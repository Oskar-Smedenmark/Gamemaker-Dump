/// create_enemy(x,y,obj_enemy,health,damageMax, damageMin, armorMax, armorMin)
var xx = argument0, yy = argument1, v_obj = argument2, v_hp = argument3, v_dmgMax = argument4, v_dmgMin = argument5, v_armMax = argument6, v_armMin = argument7;

var createdEnemy = instance_create(xx, yy, v_obj);
with(createdEnemy)
{
    hp = v_hp;
    damageMax = v_dmgMax;
    damageMin = v_dmgMin;
    armorMax = v_armMax;
    armorMin = v_armMin;
    damage[0] = irandom_range(damageMin,damageMax);
    for(var i = 0; i < elements_size(); i++)
    {
        if(random(1) >= 0.5)
        {
            armor[i] = irandom_range(armorMin, armorMax);
        }
    }
}

return createdEnemy;
