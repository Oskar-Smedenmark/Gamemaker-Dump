/// increaseTurnPos
with(obj_encounterManager)
{
    turnPos++;
    if(turnPos >= ds_list_size(turnList))
    {
        turnPos = 0;
    }
    lastMyTurn = false;
}
