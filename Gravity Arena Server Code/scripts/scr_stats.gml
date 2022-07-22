///scr_stats(buffer, socket)
var buffer = argument0;
var socket = argument1;
var latency = buffer_read(buffer, buffer_u32);
var kills = buffer_read(buffer, buffer_u32);
var deaths = buffer_read(buffer, buffer_u32);
var player = noone;

with(obj_player)
{
    if(self.playerSocket == socket)
    {
        player = id;
    }
}

if(player != noone)
{
    player.playerLatency = latency;
    player.playerKills = kills;
    player.playerDeaths = deaths;

    //Tell other players about this change
    for(var i = 0; i < ds_list_size(global.players); i++)
    {
        var storedPlayerSocket = ds_list_find_value(global.players, i);
        
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, type.stats);
        buffer_write(global.buffer, buffer_u32, player.playerId);
        buffer_write(global.buffer, buffer_u32, player.playerLatency);
        buffer_write(global.buffer, buffer_u32, player.playerKills);
        buffer_write(global.buffer, buffer_u32, player.playerDeaths);
        buffer_write(global.buffer, buffer_string, player.playerName);
        buffer_write(global.buffer, buffer_u32, player.playerLap);
        network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer));
    }
}
