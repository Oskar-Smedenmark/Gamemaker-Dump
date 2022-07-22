///scr_add_pull(object, maxForce, affectingRange, mass)
var object = argument0; //Object which the force will be added to
var force = argument1; //The maximum strength of the force
var affectingRange = argument2; //Area which are affected. (In a circle around the calling object)
var mass = argument3; //The mass of the calling object(higher mass = stronger force)

if(distance_to_object(object) <= affectingRange) //Checking if the object is inside the affecting range
{
    var sqrDistance = (sqr(distance_to_object(object)))/1000; //Takes the square distance to the object
    if(sqrDistance == 0) //Checks if it's zero just to make sure we don't divide by zero
    {
        sqrDistance = 0.1;
    }
    var pullingPower = mass / sqrDistance; //Calculates the power which should be added to the object
    if(pullingPower > force || pullingPower < 0 && pullingPower < force) //Checks if it's over the max force
    {
        pullingPower = force;
    }
    
    pullingPower *= global.gameSpeed; //You can skip this line if you don't use delta timing
    var toCenter = point_direction(object.x, object.y, x + 32, y + 32); //Checks the direction to the center
    with(object)
    {
        scr_add_motion(toCenter, pullingPower); //Applies the force to object.
    }
}

