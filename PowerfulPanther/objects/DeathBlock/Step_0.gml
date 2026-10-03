// 1. CHECK IF MAO IS TOUCHING THIS HAZARD
if (place_meeting(x, y, Mao)) 
{
    // 2. TRIGGER ROOM RESTART
    // room_restart() instantly resets the current room back to its starting state
    room_restart(); 
}