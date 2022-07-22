///randomSeed(range, x, y)
range = argument[0];

var num = 0;

switch(argument_count)
{
    case 2:
        num = argument[1];
    break;
    
    case 3:
        num = argument[1] + argument[2] * 65536;
    break;
}

var ranSeed = obj_generator.seed + num;

random_set_seed(ranSeed);
rand = irandom_range(0, range);
return rand;
