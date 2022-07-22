///scr_change_team(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var pTeam = buffer_read(buffer, buffer_string);

with(obj_player)
{
    if(playerId == pId)
    {
        playerTeam = pTeam;
    }
}
