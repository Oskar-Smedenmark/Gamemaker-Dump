/// change_state(new_state)
var newState = argument0;
with(obj_matrixManager)
{
    switch(newState)
    {
        case State.move:
            
            if(!spawnGems)
            {
                //Makes sure to only continue if there is a possible match
                move_possible();
                totalDamage = 0;
            }
        break;
        
        case State.destroy:
        
        break;
        
        case State.damage:
        break;
    }
    state = newState;
}
