///scr_movement(up, down, left, right)
var up = argument0;
var down = argument1;
var left = argument2;
var right = argument3;


//moving direction
dir = darctan2(vspd, hspd);
var accel = acc * global.gameSpeed;
if(speedLimiter)
{
    accel = acc*2 * global.gameSpeed;
}

if(!stunned)
{
    if(up)
    {
        vspd -= accel;
    }
    if(down)
    {
        vspd += accel;
    }
    if(left)
    {
        hspd -= accel;
    }
    if(right)
    {
        hspd += accel;
    }
    
    if(speedLimiter)
    {
        var spd = clamp(sqrt(power(hspd, 2) + power(vspd, 2)), 0, 40);
        var currentMaxSpd = clamp(spd - accel*2, 0, 40);
        
        if(spd > maxSpd)
        {
            dir = darctan2(vspd, hspd);
            hspd = lengthdir_x(currentMaxSpd, dir);
            vspd = -lengthdir_y(currentMaxSpd, dir);
        }  
    }
}

if(!up && !down && !right && !left && !stunned && !shooting && speedLimiter)
{
    //Horizontal
    if(hspd >= deAcc)
    {
        hspd -= deAcc;
    }
    else if(hspd <= -deAcc)
    {
        hspd += deAcc;
    }
    else
    {
        hspd = 0;
    }
    
    //Veritcal
    if(vspd >= deAcc)
    {
        vspd -= deAcc;
    }
    else if(vspd <= -deAcc)
    {
        vspd += deAcc;
    }
    else
    {
        vspd = 0;
    }    
}
//Collision + xy update
var origHspd = abs(hspd);
var origVspd = abs(vspd);
var horCol = scr_hor_collision(obj_solid, hspd * global.gameSpeed);
if(horCol)
{
    if(origHspd - damageThresholdSpd > 0)
    {
        hp -= origHspd - damageThresholdSpd;
        audio_sound_pitch(snd_hurt, random_range(1, 3));
        audio_play_sound(snd_hurt, 1, 0);
    }
}
x += hspd * global.gameSpeed;
var verCol = scr_ver_collision(obj_solid, vspd * global.gameSpeed);
if(verCol)
{
    if(origVspd - damageThresholdSpd > 0)
    {
        hp -= origVspd - damageThresholdSpd;
        audio_sound_pitch(snd_hurt, random_range(1, 3));
        audio_play_sound(snd_hurt, 1, 0);
    }
}
y += vspd * global.gameSpeed;

buffer_seek(global.buffer, buffer_seek_start, 0);
buffer_write(global.buffer, buffer_u8, type.playerPosUpdate);
buffer_write(global.buffer, buffer_u32, global.playerId);
buffer_write(global.buffer, buffer_f32, hspd);
buffer_write(global.buffer, buffer_f32, vspd);
buffer_write(global.buffer, buffer_f32, angle);
buffer_write(global.buffer, buffer_s8, image_xscale);
buffer_write(global.buffer, buffer_u32, sprite_index);
network_send_packet(obj_controller.socket, global.buffer, buffer_tell(global.buffer));
