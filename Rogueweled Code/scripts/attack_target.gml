/// attack_target(fromX,fromY,target, damage, delay, element)
var fromX = argument[0];
var fromY=argument[1];
var currentTarget=argument[2];
var currentDamage=argument[3];
var currentDelay = argument[4];
var currentElement = argument[5];
if(currentTarget != noone && instance_exists(currentTarget))
{
    var currentAttack = instance_create(fromX,fromY,obj_attack);
    with(currentAttack)
    {
        attackParticle = create_particle_attack(currentElement);
        target = currentTarget;
        damage = currentDamage;
        startMovingCounter = currentDelay;
        attackElement = currentElement;
    }
}
