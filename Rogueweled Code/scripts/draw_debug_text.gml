/// draw_debug_text(x, y, string, font, halign, color)
var currentX = argument0, currentY = argument1, currentString = argument2, currentFont = argument3, currentHalign = argument4, currentColor = argument5;
if(debug_text)
{
    draw_set_font(currentFont);
    draw_set_color(currentColor);
    draw_set_halign(currentHalign);
    draw_text(currentX,currentY,currentString);
}
