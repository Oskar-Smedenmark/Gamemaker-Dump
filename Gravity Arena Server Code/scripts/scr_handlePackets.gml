///scr_handlePackets(buffer, socket)
var buffer = argument0;
var socket = argument1;
var msgId = buffer_read(buffer, buffer_u8);

switch(msgId)
{
    case type.ping:
        scr_ping(buffer, socket);
    break;
    
    case type.join:
        scr_join(buffer, socket);
    break;
            
    case type.connect:
        scr_connect(buffer, socket);
    break;
    
    case type.playerCreateErase:
        scr_player_create_erase(buffer, socket);
    break;
    
    case type.playerOrientation:
        scr_movement(buffer, socket);
    break;
    
    case type.shooting:
        scr_shooting(buffer, socket);
    break;
    
    case type.hit:
        scr_hit(buffer, socket);
    break;
    
    case type.dead:
        scr_dead(buffer, socket);
    break;
    
    case type.spawn:
        scr_spawn(buffer, socket);
    break;
    
    case type.stats:
        scr_stats(buffer, socket);
    break;
    
    case type.spawnProtection:
        scr_spawnProtection(buffer, socket);
    break;
    
    case type.finishGame:
        scr_finish_game(buffer, socket);        
    break;
    
    case type.lobbyList:
        scr_lobbylist(buffer, socket);
    break;
    
    case type.changeTeam:
        scr_change_team(buffer, socket);
    break;
    
    case type.onFinish:
        scr_onFinish(buffer, socket);
    break;
    
    case type.onCheckpoint:
        scr_onCheckpoint(buffer, socket);
    break;
    
    case type.posInitiation:
        scr_pos_initiation(buffer, socket);
    break;
    
    case type.playerPosUpdate:
        scr_player_pos_update(buffer, socket);
    break;
    
    case type.message:
        scr_message(buffer, socket);
    break;
}
