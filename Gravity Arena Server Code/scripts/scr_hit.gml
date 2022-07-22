///scr_hit(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var lastAttacker = buffer_read(buffer, buffer_u32);
var dir = buffer_read(buffer, buffer_f32);
var bulletSpd = buffer_read(buffer, buffer_f32);
var atkDir = buffer_read(buffer, buffer_f32);
var playerHit = noone;

with(obj_player)
{
    if(playerId == pId)
    {
        playerHit = id;
    }
}
if(playerHit != noone)
{
    buffer_seek(global.buffer, buffer_seek_start, 0);
    buffer_write(global.buffer, buffer_u8, type.hit);
    buffer_write(global.buffer, buffer_u32, lastAttacker);
    buffer_write(global.buffer, buffer_f32, dir);
    buffer_write(global.buffer, buffer_f32, bulletSpd);
    buffer_write(global.buffer, buffer_f32, atkDir);
    network_send_packet(playerHit.playerSocket, global.buffer, buffer_tell(global.buffer));
}
