///scr_create_message(message)
var notification = instance_create(0, 0, obj_message);
notification.message = argument0;
audio_play_sound(snd_message, 1, 0);
