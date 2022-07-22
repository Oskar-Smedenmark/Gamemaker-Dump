///lookForEnemies()
var enemyNearby = collision_circle(x, y, detectionRange, obj_bug, false, false);
if(enemyNearby != noone)
{
    var enemySeen = collision_line(x,y, enemyNearby.x, enemyNearby.y, obj_solid, false, false);
    if(enemySeen == noone)
    {
        state = states.attack;
        target = enemyNearby;
    }
}
