///unloadChunk()
ds_map_delete(chunkLoadedSet,getKey(x,y));
/*global.minX = obj_camera.x - room_width/2;
global.minY = obj_camera.y - room_height/2;
global.offsetX = 0;
global.offsetY = 0;

global.offsetX = -global.minX div TILE_WIDTH;
global.offsetY = -global.minY div TILE_HEIGHT;
//mp_grid_destroy(global.grid);
mp_grid_clear_all(global.grid);
global.grid = mp_grid_create((global.minX div TILE_WIDTH) * TILE_WIDTH, (global.minY div TILE_WIDTH) * TILE_WIDTH, room_width div TILE_WIDTH, room_height div TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT);
mp_grid_add_instances(global.grid, obj_solid, false);
obj_world_controller.solidGrid = ds_grid_create(room_width div TILE_WIDTH, room_height div TILE_HEIGHT);
mp_grid_to_ds_grid(global.grid, obj_world_controller.solidGrid);*/
