///scr_onCheckpoint(buffer, socket)
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
    if(player.playerCheckpoint == false)
    {
        player.playerCheckpoint = true;
    }
}
