/// elements_strength(element1, element2)
var currentEle1 = argument0, currentEle2 = argument1;
switch(currentEle1)
{
    case Element.white:
        return 1;
    break;
    case Element.red:
        switch(currentEle2)
        {
            case Element.green:
                return 2;
            break;
            case Element.blue:
                return 0.5;
            break;
            default:
                return 1;        
            break;
        }
    break;
    case Element.green:
        switch(currentEle2)
        {
            case Element.red:
                return 0.5;
            break;
            case Element.blue:
                return 2;
            break;
            default:
                return 1;        
            break;
        }
    break;
    case Element.blue:
        switch(currentEle2)
        {
            case Element.red:
                return 2;
            break;
            case Element.green:
                return 0.5;
            break;
            default:
                return 1;        
            break;
        }
    break;
    case Element.purple:
        switch(currentEle2)
        {
            case Element.yellow:
                return 1;
            break;
            case Element.red:
                return 1.5;
            break;
            case Element.blue:
                return 1.5;
            break;
            default:
                return 1;        
            break;
        }
    break;
    case Element.yellow:
        switch(currentEle2)
        {
            case Element.cyan:
                return 2.5;
            break;
            case Element.red:
                return 1.5;
            break;
            case Element.green:
                return 1.5;
            break;
            default:
                return 1;        
            break;
        }
    break;
    case Element.cyan:
        switch(currentEle2)
        {
            case Element.purple:
                return 2.5;
            break;
            case Element.green:
                return 1.5;
            break;
            case Element.blue:
                return 1.5;
            break;
            default:
                return 1;        
            break;
        }
    break;
    default:
        return 1;
    break;
}
