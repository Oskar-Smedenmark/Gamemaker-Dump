for(var i = 0; i < chunkSize / blockSize; i++)
{
    for(var j = 0; j < chunkSize / blockSize; j++)
    {
        var zz = 1 + getPerlinNoise_2D(x / blockSize + i, y / blockSize + j, 100);
        terrainGrid[# i,j] = zz;
    }
}
