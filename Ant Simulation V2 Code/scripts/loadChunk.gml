///loadChunk()
var numSideBlocks = chunkSize div blockSize;
terrainGrid = ds_grid_create(numSideBlocks, numSideBlocks);

generate();

ds_map_add(chunkLoadedSet,getKey(x,y),1);
