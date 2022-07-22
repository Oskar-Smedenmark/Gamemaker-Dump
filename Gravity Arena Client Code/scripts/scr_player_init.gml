///scr_player_init()
hspd = 0;
vspd = 0;
hp = 20;
maxSpd = 5;
movSpd = 0;
acc = 0.1;
deAcc = 0.1;
damageThresholdSpd = 6;
angle = 0;
dir = 0;
if(global.gamemode == "race")
{
    speedLimiter = false;
}
else
{
    speedLimiter = true;
}
//Weapon
switch(global.character)
{
    case "sniper":
        shotDelay = 60 * 5;
        shotCounter = 0;
        bulletPadding = 24;
        recoil = 10;
        bulletSpd = 30;
        
    break;
    
    case "assault":
        shotDelay = 60/4;
        shotCounter = 0;
        bulletPadding = 20;
        recoil = 0.2;
        bulletSpd = 10;
    break;
}
shooting = false;

stunned = false;
stunnedTime = 60 / 2;
stunnedCounter = 0;

atkDirection = 90;
