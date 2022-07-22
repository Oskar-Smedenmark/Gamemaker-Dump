/// make_gems_fall()

with(obj_matrixManager)
{
    for(var j = height-1; j > 0; j--)
    {
        for(var i = 0; i < width; i++)
        {
            gem_fall(gemGrid[# i, j]);
        }
    }
}
