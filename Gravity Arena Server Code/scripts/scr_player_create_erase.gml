///scr_player_create_erase(buffer, socket)
var buffer = argument0;
var socket = argument1;
var pId = buffer_read(buffer, buffer_u32);
var sentCharacter = buffer_read(buffer, buffer_string);
var pName = "";
var pTeam = "";
var pChar = "";

with(obj_player)
{
    if(playerId == pId)
    {
        playerInGame = !playerInGame;
        pName = playerName;
        pTeam = playerTeam;
        playerCharacter = sentCharacter;
        pChar = sentCharacter;
    }
}

//Tell other players about this change
for(var i = 0; i < ds_list_size(global.players); i++)
{
    var storedPlayerSocket = ds_list_find_value(global.players, i);
    
    if(storedPlayerSocket != socket)
    {
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, type.playerCreateErase);
        buffer_write(global.buffer, buffer_u32, pId);
        buffer_write(global.buffer, buffer_string, pName);
        buffer_write(global.buffer, buffer_string, pTeam);
        buffer_write(global.buffer, buffer_string, pChar);
        network_send_packet(storedPlayerSocket, global.buffer, buffer_tell(global.buffer));
    }
}

//Tell me about other players
for(var i = 0; i < ds_list_size(global.players); i++)
{
    var storedPlayerSocket = ds_list_find_value(global.players, i);
    
    if(storedPlayerSocket != socket)
    {
        var player = noone;
        with(obj_player)
        {
            if(self.playerSocket == storedPlayerSocket)
            {
                player = id;
            }
        }
        
        if(player != noone)
        {   
            if(player.playerInGame)
            {
                buffer_seek(global.buffer, buffer_seek_start, 0);
                buffer_write(global.buffer, buffer_u8, type.playerCreateErase);
                buffer_write(global.buffer, buffer_u32, player.playerId);
                buffer_write(global.buffer, buffer_string, player.playerName);
                buffer_write(global.buffer, buffer_string, player.playerTeam);
                buffer_write(global.buffer, buffer_string, player.playerCharacter);
                network_send_packet(socket, global.buffer, buffer_tell(global.buffer));
            }
        }
    }
}
