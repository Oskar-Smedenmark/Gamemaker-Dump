///scr_handlePackets(buffer, socket)
var buffer = argument0;
var msgId = buffer_read(buffer, buffer_u8);

switch(msgId)
{
    case type.ping:
        var time = buffer_read(buffer, buffer_u32);
        global.latency = current_time - time;
    break;
    
    case type.join:
        var pId = buffer_read(buffer, buffer_u32);
        var name = buffer_read(buffer, buffer_string);
        var team = buffer_read(buffer, buffer_string);
        var amountOfPlayers = buffer_read(buffer, buffer_u32);
        global.gameStarted = buffer_read(buffer, buffer_bool);
        global.map = buffer_read(buffer, buffer_string) + ".csv";
        var mapSize = buffer_read(buffer, buffer_u32);
        
        //Set the arena to the correct width/height
        room_set_width(rm_arena, mapSize);
        room_set_height(rm_arena, mapSize);
        
        audio_play_sound(snd_join, 1, 0);
        
        switch(global.gamemode)
        {
            case "td":
                if(global.playerId != pId)
                {
                    scr_create_message(name + " has joined the " + team + " team");
                }
            break;
            case "ffa":
                if(global.playerId != pId)
                {
                    scr_create_message(name + " has joined the arena");
                }
            break;
        }
    break;
    
    case type.connect:
        global.playerId = buffer_read(buffer, buffer_u32);
        global.gamemode = buffer_read(buffer, buffer_string);
        global.map = buffer_read(buffer, buffer_string) + ".csv";
        var mapSize = buffer_read(buffer, buffer_u32);
        global.weaponsDisabled = buffer_read(buffer, buffer_bool);
        
        //Set the arena to the correct width/height
        room_set_width(rm_arena, mapSize);
        room_set_height(rm_arena, mapSize);
        
        if(global.gamemode == "td")
        {
            room_goto(rm_lobby_team_deathmatch);
        }
        else if(global.gamemode == "ffa")
        {
            room_goto(rm_lobby_free_for_all);
        }
        else if(global.gamemode == "race")
        {
            room_goto(rm_lobby_free_for_all);
        }
        scr_create_message("Got a player ID");
        
        buffer_seek(global.buffer, buffer_seek_start, 0);
        buffer_write(global.buffer, buffer_u8, type.connect);
        buffer_write(global.buffer, buffer_u32, global.playerId);
        buffer_write(global.buffer, buffer_string, global.name);
        buffer_write(global.buffer, buffer_string, global.team);
        network_send_packet(socket, global.buffer, buffer_tell(global.buffer));
    break;
    
    case type.disconnect:
        var pId = buffer_read(buffer, buffer_u32);
        var pName = "";
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                pName = remotePlayerName;
                instance_destroy();
            }
        }
        with(obj_lobby_player)
        {
            if(lobbyPlayerId == pId)
            {
                pName = self.name;
                instance_destroy();
            }
        }
        scr_create_message(pName + " has left the game!");
    break;
    
    case type.playerCreateErase:
        var pId = buffer_read(buffer, buffer_u32);
        var pName = buffer_read(buffer, buffer_string);
        var pTeam = buffer_read(buffer, buffer_string);
        var pChar = buffer_read(buffer, buffer_string);
        
        var instance = noone;
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                instance = id;
            }
        }
        
        if(instance == noone)
        {
            //only if we're in the gameworld
            
                //create a remote player
                var remotePlayer = instance_create(0, 0, obj_remote_player);
                remotePlayer.remotePlayerId = pId;
                remotePlayer.remotePlayerName = pName;
                remotePlayer.remotePlayerTeam = pTeam;
                remotePlayer.remotePlayerCharacter = pChar;
                with(remotePlayer)
                {
                    if(remotePlayerTeam == "Red")
                    {
                        switch(pChar)
                        {
                            case "sniper":
                                sprite_index = spr_sniper;
                                weaponSprite = spr_weapon_sniper;
                            break;
                            
                            case "assault":
                                sprite_index = spr_player_red;
                                weaponSprite = spr_pea_shooter_red;
                            break;
                        }
                    }
                    else if(remotePlayerTeam == "Blue")
                    {
                        switch(pChar)
                        {
                            case "sniper":
                                sprite_index = spr_sniper;
                                weaponSprite = spr_weapon_sniper;
                            break;
                            
                            case "assault":
                                sprite_index = spr_player_blue;
                                weaponSprite = spr_pea_shooter_blue;
                            break;
                        }
                    }
                    else
                    {
                        switch(pChar)
                        {
                            case "sniper":
                                sprite_index = spr_sniper;
                                weaponSprite = spr_weapon_sniper;
                            break;
                            
                            case "assault":
                                sprite_index = spr_player_red;
                                weaponSprite = spr_pea_shooter_red;
                            break;
                        }
                    }
                }
            
        }
        else
        {
            with(instance)
            {
                instance_destroy();
            }
            scr_create_message(pName + " has left the arena!");
        }
    break;
    
    case type.playerOrientation:
        var pId = buffer_read(buffer, buffer_u32);
        var angle = buffer_read(buffer, buffer_f32);
        var pDirection = buffer_read(buffer, buffer_s8);
        var pSprite = buffer_read(buffer, buffer_u32);
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                remoteWeaponAngle = angle;
                remotePlayerDirection = pDirection;
                sprite_index = pSprite;
            }
        }
    break;
    
    case type.shooting:
        var pId = buffer_read(buffer, buffer_u32);
        var dir = buffer_read(buffer, buffer_f32);
        var spd = buffer_read(buffer, buffer_f32);
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                var bullet = instance_create(x + lengthdir_x(bulletPadding, dir), y + lengthdir_y(bulletPadding, dir), obj_remote_bullet);
                bullet.dir = dir;
                bullet.spd = spd;
                bullet.owner = id;
            }
        }
    break;
    
    case type.hit:
        var lastAttacker = buffer_read(buffer, buffer_u32);
        var dir = buffer_read(buffer, buffer_f32);
        var bulletSpd = buffer_read(buffer, buffer_f32);
        var atkDir = buffer_read(buffer, buffer_f32);
        var attackingPlayer = noone;
        
        with(obj_remote_player)
        {
            if(remotePlayerId = lastAttacker)
            {
                attackingPlayer = id;
            }
        }
        if(attackingPlayer != noone)
        {
            with(obj_local_player)
            {
                if(attackingPlayer.remotePlayerTeam != global.team)
                {
                    global.lastHitBy = lastAttacker;
                    scr_add_motion(atkDir, bulletSpd * global.gameSpeed);
                    stunned = true;
                    stunnedCounter = stunnedTime;
                    
                    audio_play_sound(snd_hit, 1, 0);
                }
            }
        }
    break;
    
    case type.dead:
        var pId = buffer_read(buffer, buffer_u32);
        var killerId = buffer_read(buffer, buffer_u32);
        var pName = buffer_read(buffer, buffer_string);
        var killerName = buffer_read(buffer, buffer_string);
        if(killerName == "")
        {
            killerName = "himself";
        }
        var instance = noone;
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                instance = id;
            }
        }
        with(obj_local_player)
        {
            if(global.playerId == killerId)
            {
                global.kills++;
            }
        }
        
        if(instance == noone)
        {
            //Do nothing(should genreally never happen)
        }
        else
        {
            with(instance)
            {
                instance_destroy();
            }
            scr_create_message(pName + " was killed by " + killerName);
        }
    break;
    
    case type.spawn:
        var pId = buffer_read(buffer, buffer_u32);
        var pName = buffer_read(buffer, buffer_string);
        var pLatency = buffer_read(buffer, buffer_u32);
        var pKills = buffer_read(buffer, buffer_u32);
        var pDeaths = buffer_read(buffer, buffer_u32);
        var pTeam = buffer_read(buffer, buffer_string);
        var pChar = buffer_read(buffer, buffer_string);
        
        var instance = noone;
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                instance = id;
            }
        }
        
        if(instance == noone)
        {
            //create a remote player
            var remotePlayer = instance_create(x, y, obj_remote_player);
            remotePlayer.remotePlayerId = pId;
            remotePlayer.remotePlayerName = pName;
            remotePlayer.remotePlayerLatency = pLatency;
            remotePlayer.remotePlayerKills = pKills;
            remotePlayer.remotePlayerDeaths = pDeaths;
            remotePlayer.remotePlayerTeam = pTeam;
            remotePlayer.remotePlayerCharacter = pChar;
            with(remotePlayer)
            {
                sprite_index = remotePlayerCharacter;
                switch(remotePlayerCharacter)
                {
                    case "sniper":
                        weaponSprite = spr_weapon_sniper;
                    break;
                    
                    case "assault":
                        weaponSprite = spr_pea_shooter_red;
                    break;
                }
            }
        }
        else
        {
            //Already exsists(shouldn't generally ever happen)
        }
    break;
    
    case type.stats:
        var pId = buffer_read(buffer, buffer_u32);
        var latency = buffer_read(buffer, buffer_u32);
        var kills = buffer_read(buffer, buffer_u32);
        var deaths = buffer_read(buffer, buffer_u32);
        var pName = buffer_read(buffer, buffer_string);
        var pLap = buffer_read(buffer, buffer_u32);
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                remotePlayerName = pName;
                remotePlayerLatency = latency;
                remotePlayerKills = kills;
                remotePlayerDeaths = deaths;
            }
        }
        if(global.playerId == pId)
        {
            global.lap = pLap;
        }
        
    break;
    
    case type.winner:
        var pName = buffer_read(buffer, buffer_string);
        global.map = buffer_read(buffer, buffer_string) + ".csv";
        global.winner = pName;
        global.endGame = true;
    break;
    
    case type.spawnProtection:
        var pId = buffer_read(buffer, buffer_u32);
        var spawnStrength = buffer_read(buffer, buffer_u32);
        var playerProtected = noone;
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                playerProtected = id;
            }
        }
        
        if(global.gamemode == "td")
        {
            if(playerProtected != noone)
            {
                with(obj_local_player)
                {
                    if(distance_to_object(playerProtected) <= 400 && playerProtected.remotePlayerTeam != global.team)
                    {
                        scr_add_motion(point_direction(playerProtected.x, playerProtected.y, x, y), spawnStrength);
                    }
                }
            }
        }
    break;
    
    case type.finishGame:
        global.kills = 0;
        global.deaths = 0;
        global.shownWinner = false;
        global.gameStarted = false;
        /*with(obj_controller)
        {
            network_destroy(socket);
            buffer_delete(global.buffer);
            instance_destroy();
        }
        instance_create(x, y, obj_controller);*/
        switch(global.gamemode)
        {
            case "td":
                room_goto(rm_lobby_team_deathmatch);
            break;
            
            case "ffa":
                room_goto(rm_lobby_free_for_all);
            break;
            
            case "race":
                room_goto(rm_lobby_free_for_all);
            break;
        };
    break;
    
    case type.lobbyList:
        var pId = buffer_read(buffer, buffer_u32);
        var amountOfPlayers = buffer_read(buffer, buffer_u32);
        var pTeam = buffer_read(buffer, buffer_string);
        var pName = buffer_read(buffer, buffer_string);
        var exists = false;
        
        with(obj_lobby_player)
        {
            if(lobbyPlayerId == pId)
            {
                self.team = pTeam;
                self.name = pName;
                exists = true;
            }
        }
        if(!exists)
        {
            var lobbyPlayer = instance_create(x, y, obj_lobby_player);
            lobbyPlayer.lobbyPlayerId = pId;
            lobbyPlayer.team = pTeam;
            lobbyPlayer.name = pName; 
        }
    break;
    
    case type.disableEnableWeapons:
        global.weaponsDisabled = buffer_read(buffer, buffer_bool);
        
        switch(global.weaponsDisabled)
        {
            case true:
                scr_create_message("Weapons disabled.");
            break;
            
            case false:
                scr_create_message("Weapons enabled.");
            break;
        }
    break;
    
    case type.startTimer:
        global.gameCountDown = buffer_read(buffer, buffer_u32) - 1;
        
        if(global.gameCountDown % 60 == 0 && !global.gameStarted)
        {
            audio_play_sound(snd_start_beep, 1, 0);
            audio_sound_pitch(snd_start_beep, startBeepPitch);
            startBeepPitch++;
        }
        if(global.gameStarted)
        {
            startBeepPitch = 1;
        }
    break;
    
    case type.playerPosUpdate:
        var pId = buffer_read(buffer, buffer_u32);
        var xPos = buffer_read(buffer, buffer_f32);
        var yPos = buffer_read(buffer, buffer_f32);
        
        if(pId != global.playerId)
        {
            with(obj_remote_player)
            {
                if(pId == remotePlayerId)
                {
                    x = xPos;
                    y = yPos;
                }
            }
        }        
    break;
    
    case type.playerCreate:
    
        var pId = buffer_read(buffer, buffer_u32);
        var pName = buffer_read(buffer, buffer_string);
        var pTeam = buffer_read(buffer, buffer_string);
        var pChar = buffer_read(buffer, buffer_string);
        
        var instance = noone;
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                instance = id;
            }
        }
        if(instance == noone && pId != global.playerId)
        {
            //create a remote player
            var remotePlayer = instance_create(0, 0, obj_remote_player);
            remotePlayer.remotePlayerId = pId;
            remotePlayer.remotePlayerName = pName;
            remotePlayer.remotePlayerTeam = pTeam;
            remotePlayer.remotePlayerCharacter = pChar;
            with(remotePlayer)
            {
                if(remotePlayerTeam == "Red")
                {
                    switch(pChar)
                    {
                        case "sniper":
                            sprite_index = spr_sniper;
                            weaponSprite = spr_weapon_sniper;
                        break;
                        
                        case "assault":
                            sprite_index = spr_player_red;
                            weaponSprite = spr_pea_shooter_red;
                        break;
                    }
                }
                else if(remotePlayerTeam == "Blue")
                {
                    switch(pChar)
                    {
                        case "sniper":
                            sprite_index = spr_sniper;
                            weaponSprite = spr_weapon_sniper;
                        break;
                        
                        case "assault":
                            sprite_index = spr_player_blue;
                            weaponSprite = spr_pea_shooter_blue;
                        break;
                    }
                }
                else
                {
                    switch(pChar)
                    {
                        case "sniper":
                            sprite_index = spr_sniper;
                            weaponSprite = spr_weapon_sniper;
                        break;
                        
                        case "assault":
                            sprite_index = spr_player_red;
                            weaponSprite = spr_pea_shooter_red;
                        break;
                    }
                }
            }
        }
    break;
    
    case type.message:
        var pId = buffer_read(buffer, buffer_u32);
        var theText = buffer_read(buffer, buffer_string);
        
        var thePlayer = noone;
        var playerName = "";
        
        with(obj_remote_player)
        {
            if(remotePlayerId == pId)
            {
                thePlayer = id;
                playerName = remotePlayerName;
            }
        }
        
        with(obj_lobby_player)
        {
            if(lobbyPlayerId == pId)
            {
                thePlayer = id;
                playerName = self.name;
            }
        }
        
        if(thePlayer != noone)
        {
            //Create the message
            scr_log_message(theText, playerName);
            recievedMessageTimer = messagePopUpTime;
        }
    break;
}
