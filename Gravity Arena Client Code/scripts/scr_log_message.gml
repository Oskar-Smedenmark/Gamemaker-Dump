///scr_log_message(text, playerName)
var theText = argument0;
var playerName = argument1;
nrOfMessages++;
if(nrOfMessages > maxMessages)
{
    nrOfMessages = maxMessages;
    var temp = "";
    for(var i = 1; i < maxMessages; i++)
    {
        chatlog[i - 1] = chatlog[i];
    }
    chatlog[nrOfMessages - 1] = playerName + ": " + theText;
}
else
{
    chatlog[nrOfMessages - 1] = playerName + ": " + theText;
}
