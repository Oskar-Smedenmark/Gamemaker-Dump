///scr_lobbylist(buffer, socket)
var buffer = argument0;
var socket = argument1;
var player = noone;
//Tell me about other players
for(var i = 0; i < ds_list_size(global.players); i++)
{
    var storedPlayerSocket = ds_list_find_value(global.players, i);
    with(obj_player)
    {
        if(storedPlayerSocket == playerSocket)
        {
            player = id;
        }
    }
    if(player != noone)
    {
        if(storedPlayerSocket != socket)
        {
            buffer_seek(global.buffer, buffer_seek_start, 0);
            buffer_write(global.buffer, buffer_u8, type.lobbyList);
            buffer_write(global.buffer, buffer_u32, player.playerId);
            buffer_write(global.buffer, buffer_u32, ds_list_size(global.players) - 1);
            buffer_write(global.buffer, buffer_string, player.playerTeam);
            buffer_write(global.buffer, buffer_string, player.playerName);
            network_send_packet(socket, global.buffer, buffer_tell(global.buffer));
        }
    }
    player = noone;
}
