///create_particle_attack(element)
var currentElement = argument0;
var p_attack = part_type_create();
part_type_shape(p_attack,pt_shape_flare);
part_type_size(p_attack,0.05,0.20,0,0);
part_type_scale(p_attack,4,4);
part_type_color3(p_attack,currentElement,currentElement,currentElement);
part_type_alpha3(p_attack,0.68,0.56,0.05);
part_type_speed(p_attack,2.76,4.52,-0.16,0);
part_type_direction(p_attack,0,359,0,0);
part_type_gravity(p_attack,0.05,270);
part_type_orientation(p_attack,0,0,0,0,0);
part_type_blend(p_attack,1);
part_type_life(p_attack,44,65);

return p_attack;

/*e_attack = part_emitter_create(global.P_System);
part_emitter_region(global.P_System,e_attack,x,x,y,y,ps_shape_ellipse,ps_distr_gaussian);
part_emitter_stream(global.P_System,e_attack,p_attack,2);*/
