///scr_ping(buffer, socket)
var buffer = argument0;
var socket = argument1;
var time = buffer_read(buffer, buffer_u32);
        
buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u8, type.ping);
buffer_write(global.buffer, buffer_u32, time);
//send back to player who sent this message
network_send_packet(socket, global.buffer, buffer_tell(global.buffer));
