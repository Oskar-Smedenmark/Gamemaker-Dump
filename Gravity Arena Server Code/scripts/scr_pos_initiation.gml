///scr_pos_initiation(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var xPosition = buffer_read(buffer, buffer_f32);
var yPosition = buffer_read(buffer, buffer_f32);

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
    player.xPos = xPosition;
    player.yPos = yPosition;
}
