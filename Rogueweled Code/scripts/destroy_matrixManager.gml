/// destroy_matrixManager()

with(obj_matrixManager)
{
    ds_list_destroy(gemInventory);
    ds_list_destroy(drawGemList);
    ds_list_destroy(discardGemList);
    for(var i = 0; i < width; i++)
    {
        for(var j = 0; j < height; j++)
        {
            with(gemGrid[# i, j])
            {
                instance_destroy();
            }
        }
    }
    for(var i = 0; i < previewRowAmount; i++)
    {
        ds_list_destroy(ds_list_pop(nextRows));
    }
    ds_list_destroy(nextRows);
    ds_grid_destroy(gemGrid);
    instance_destroy();
}
