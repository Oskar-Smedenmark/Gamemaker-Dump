///scr_create_message(message)
with(obj_message)
{
    instance_destroy();
}

var notification = instance_create(0, 0, obj_message);
notification.message = argument0;
