///scr_draw_layer()
if(layer == global.currentLayer)
{
    image_alpha = 1;
    draw_self();
}
else
{
    image_alpha = 1 / (abs(layer-global.currentLayer)*2+1);
    if(abs(layer-global.currentLayer) > 4)
    {
        image_alpha = 0;
    }
    draw_self();
}
