///scr_attack()
if(target == noone)
{
    return scr_reset_state(false, "ATTACKING: No target");
}
else
{
    if(instance_exists(target))
    {   
        if(!scr_create_path(path, target.x, target.y, spd, true))
        {
            return scr_reset_state(false, "ATTACKING: No path to target");
        }
        if(distance_to_object(target) < attackRange)
        {
            attackCounter--;
            if(attackCounter <= 0)
            {
                attackCounter = attackSpeed;
                target.hp -= dmg;
                with(target)
                {
                    part_particles_create(obj_ps.ps_blood, x, y, obj_ps.part_blood, 16);
                }
            }
        }
    }
    else
    {
        return scr_reset_state(true, "ATTACKING: Target is Dead");
    }
}
