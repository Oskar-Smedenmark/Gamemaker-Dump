///scr_destroy_bullet()
instance_destroy();
var bulletAngle = image_angle;
with(instance_create(x, y, obj_explosion))
{
    image_angle = bulletAngle;
}
