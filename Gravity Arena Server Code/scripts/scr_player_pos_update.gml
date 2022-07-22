///scr_player_pos_update(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var horSpd = buffer_read(buffer, buffer_f32);
var verSpd = buffer_read(buffer, buffer_f32);
var angle = buffer_read(buffer, buffer_f32);
var pDirection = buffer_read(buffer, buffer_s8);
var pSprite = buffer_read(buffer, buffer_u32);

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
    player.hspd = horSpd;
    player.vspd = verSpd;
}

//Tell other players about this change
for(var i = 0; i < ds_list_size(global.players); i++)
{
    var storedPlayerSocket = ds_list_find_value(global.players, i);
    
    if(storedPlayerSocket != socket)
    {
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, type.playerOrientation);
        buffer_write(global.buffer, buffer_u32, pId);
        buffer_write(global.buffer, buffer_f32, angle);
        buffer_write(global.buffer, buffer_s8, pDirection);
        buffer_write(global.buffer, buffer_u32, pSprite);
        network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer));
    }
}
