///scr_reset_state(success(boolean), string)
state = states.idle;
target = noone;
goingToTarget = false;
readyToCarry = false;
xTo = x;
yTo = y;
if(argument_count > 1 && !argument[0])
{
    print(argument[1]);
}
return argument[0];
