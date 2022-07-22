///spawnChunks(x,y)
var px = argument[0];
var py = argument[1];

px -= px % chunkSize;
py -= py % chunkSize;

var chunkRadius = chunkSize * ceil(spawnRange div chunkSize);
var amountOfChunks = 0;
var spawnedChunk = false;

for(var i = px - chunkRadius; i <= px + chunkRadius; i += chunkSize)
{
    for(var j = py - chunkRadius; j <= py + chunkRadius; j += chunkSize)
    {
        if(!chunkLoaded(i,j) && pointInSpawnRange(i+(chunkSize/2), j+(chunkSize/2)))
        {
            amountOfChunks++;
            print("LOADED ", amountOfChunks);
            instance_create(i,j,oChunk);
            spawnedChunk = true;
        }
    }
}

