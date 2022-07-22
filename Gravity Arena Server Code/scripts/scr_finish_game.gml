///scr_finish_game(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);

with(obj_player)
{
    if(self.playerId == pId)
    {
        playerInGame = !playerInGame;
        playerLatency = 0;
        playerKills = 0;
        playerDeaths = 0;
        playerCheckpoint = false;
        playerFinish = false;
        playerPos = 1;
        playerLap = 1;
    }   
}

playerHasFinished = false;
winningPlayer = noone;

buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u8, type.finishGame);
network_send_packet(socket, global.buffer, buffer_tell(global.buffer));
