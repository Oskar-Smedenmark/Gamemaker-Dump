///scr_dead(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var pName = "";
var killerId = buffer_read(buffer, buffer_u32);
var killerName = "";

with(obj_player)
{
    if(self.playerId == pId)
    {
        playerInGame = !playerInGame;
        pName = playerName;
    }
    if(self.playerId == killerId)
    {
        killerName = playerName;
    }
}

//Tell other players about this change
for(var i = 0; i < ds_list_size(global.players); i++)
{
    var storedPlayerSocket = ds_list_find_value(global.players, i);
    
    if(storedPlayerSocket != socket)
    {
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, type.dead);
        buffer_write(global.buffer, buffer_u32, pId);
        buffer_write(global.buffer, buffer_u32, killerId);
        buffer_write(global.buffer, buffer_string, pName);
        buffer_write(global.buffer, buffer_string, killerName);
        network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer));
    }
}
