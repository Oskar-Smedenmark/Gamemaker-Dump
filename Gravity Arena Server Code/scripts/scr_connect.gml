///scr_connect(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var pName = buffer_read(buffer, buffer_string);
var pTeam = buffer_read(buffer, buffer_string);

with(obj_player)
{
    if(playerId == pId)
    {
        playerName = pName;
        playerTeam = pTeam;
    }
}
