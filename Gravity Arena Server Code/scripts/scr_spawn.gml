///scr_spawn(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var pName = "";
var player = noone;

with(obj_player)
{
    if(self.playerId == pId)
    {
        playerInGame = !playerInGame;
        pName = playerName;
        player = id;
    }
}

//Tell other players about this change
for(var i = 0; i < ds_list_size(global.players); i++)
{
    var storedPlayerSocket = ds_list_find_value(global.players, i);
    
    if(storedPlayerSocket != socket)
    {
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, type.spawn);
        buffer_write(global.buffer, buffer_u32, pId);
        buffer_write(global.buffer, buffer_string, pName);
        buffer_write(global.buffer, buffer_u32, player.playerLatency);
        buffer_write(global.buffer, buffer_u32, player.playerKills);
        buffer_write(global.buffer, buffer_u32, player.playerDeaths);
        buffer_write(global.buffer, buffer_string, player.playerTeam);
        buffer_write(global.buffer, buffer_string, player.playerCharacter);
        network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer));
    }
}
