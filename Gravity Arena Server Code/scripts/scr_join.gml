///scr_join(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var name = buffer_read(buffer, buffer_string);
var team = buffer_read(buffer, buffer_string);
var character = buffer_read(buffer, buffer_string);

//Tell users
for(var i = 0; i < ds_list_size(global.players); i++)
{
    buffer_seek(global.buffer, buffer_seek_start, 0);
    buffer_write(global.buffer, buffer_u8, type.join);
    buffer_write(global.buffer, buffer_u32, pId);
    buffer_write(global.buffer, buffer_string, name);
    buffer_write(global.buffer, buffer_string, team);
    buffer_write(global.buffer, buffer_u32, ds_list_size(global.players));
    buffer_write(global.buffer, buffer_bool, gameStarted);
    buffer_write(global.buffer, buffer_string, currentMap);
    buffer_write(global.buffer, buffer_u32, global.mapSize);
    network_send_packet(ds_list_find_value(global.players, i), global.buffer, buffer_tell(global.buffer));
}
with(obj_player)
{
    if(playerId == pId)
    {
        playerName = name;
        playerTeam = team;
        playerCharacter = character;
    }
}
