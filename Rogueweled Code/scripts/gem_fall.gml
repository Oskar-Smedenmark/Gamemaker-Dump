///gem_fall(bottom_gem)
var gem = argument0;
if(gem == undefined)
{
    gem = noone;
}
if(gem != noone && gem.gType == Types.blank)
{
    if(gem.gridPosY-1 >= 0)
    {
        var nextGem = gem_fall(obj_matrixManager.gemGrid[# gem.gridPosX, gem.gridPosY-1]);
        if(nextGem != noone && nextGem.gType != Types.blank)
        {
            nextGem.yTo = gem.gridPosY*obj_matrixManager.offset + obj_matrixManager.yStart;
            gem.yTo = nextGem.gridPosY*obj_matrixManager.offset + obj_matrixManager.yStart;
            nextGem.gridPosY++;
            obj_matrixManager.gemGrid[# nextGem.gridPosX, nextGem.gridPosY] = nextGem;
            gem.gridPosY--;
            obj_matrixManager.gemGrid[# gem.gridPosX, gem.gridPosY] = gem;
        }
        return nextGem;
    }
    gem = noone;
}

return gem;

