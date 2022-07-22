///scr_onFinish(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var player = noone;
with(obj_player)
{
    if(playerId == pId)
    {
        player = id;
    }
}

if(player != noone)
{
    if(player.playerCheckpoint == true && player.playerLap >= global.lapsToWin)
    {
        player.playerFinish = true;
    }
    
    if(player.playerCheckpoint == true && player.playerLap < global.lapsToWin)
    {
        player.playerLap++;
        player.playerCheckpoint = false;
    }
    
    if(playerHasFinished == false && player.playerFinish == true)
    {
        playerHasFinished = true;
        winningPlayer = player.id;
    }
}
