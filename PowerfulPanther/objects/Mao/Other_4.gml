// CONDITION A: Entering the Underworld Room
if (room == YarnRoom) 
{
    state = -1; 
    x = room_width / 2;
    y = room_height - 128;
    hsp = 0;
    vsp = 0;
} 
// CONDITION B: Returning from the Underworld back to a Normal Level
else if (global.was_in_yarn == true) 
{
    x = global.saved_x;
    y = global.saved_y;
    state = 0; 
    global.was_in_yarn = false; 
}
// CONDITION C: Stepping into a Brand New Level (or Standard Room Restart)
else 
{
    // Because we deleted Mao from Room 2, GameMaker can't use 'xstart/ystart' 
    // from the grid. Instead, we find the invisible Spawner object in the new room
    // and snap Mao directly to it!
    if (instance_exists(MaoStartingPosition))
    {
        x = MaoStartingPosition.x;
        y = MaoStartingPosition.y;
    }
    else
    {
        // Fallback to default room coordinates if no spawner exists
        x = 100;
        y = 100;
    }
    
    // Clean out broken momentum vectors for the fresh room
    hsp = 0;
    vsp = 0;
}

switch (room)
{
	case Room1: state = 2; break;
	case Room2: state = 1; break;
	case Room3: state = 3; break;
	case YarnRoom: state = 1; break;
	default: state = 2;
}