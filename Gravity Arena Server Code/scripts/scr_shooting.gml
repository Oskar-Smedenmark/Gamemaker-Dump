///scr_shooting(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var dir = buffer_read(buffer, buffer_f32);
var spd = buffer_read(buffer, buffer_f32);

//Tell other players about this change
for(var i = 0; i < ds_list_size(global.players); i++)
{
    var storedPlayerSocket = ds_list_find_value(global.players, i);
    
    if(storedPlayerSocket != socket)
    {
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, type.shooting);
        buffer_write(global.buffer, buffer_u32, pId);
        buffer_write(global.buffer, buffer_f32, dir);
        buffer_write(global.buffer, buffer_f32, spd);
        network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer));
    }
}
