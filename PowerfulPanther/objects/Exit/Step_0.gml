// 1. IF THE LEVEL IS NOT YET COMPLETE, WATCH FOR MAO
if (!level_complete) 
{
    if (place_meeting(x, y, Mao)) 
    {
        level_complete = true;
		audio_play_sound(SndExit, 5, false); 
        
        // Stop Mao in his tracks so he freezes on the exit
        if (instance_exists(Mao)) 
        {
            Mao.hsp = 0;
            Mao.vsp = 0;
            //Mao.state = -1; // Lock inputs by shifting out of states 0-3
        }
        
        // Grab the exact time string currently displayed by your UI/Spawner object
        // (Assuming your UI/spawner is named obj_ui, change if using obj_spawner)
        if (instance_exists(UI)) 
        {
            // Access the time calculations we built earlier
            var _minutes = floor(UI.total_seconds / 60);
            var _seconds = floor(UI.total_seconds mod 60);
            
            var _str_mins = (_minutes < 10) ? "0" + string(_minutes) : string(_minutes);
            var _str_secs = (_seconds < 10) ? "0" + string(_seconds) : string(_seconds);
            
            final_time_string = _str_mins + ":" + _str_secs;
            
            // Freeze the UI timer so it stops counting up
            instance_deactivate_object(UI); 
        }
    }
}
// 2. COUNT DOWN THE DISPLAY DELAY THEN TRANSITION
else 
{
    transition_timer--;
    
    if (transition_timer <= 0) 
    {
        // Check if there actually is a next room in your asset tree to prevent crashes
		var _next_room = room_next(room);
        if (room_exists(_next_room) && (_next_room != YarnRoom))
        {
            room_goto_next();
        } 
        else 
        {
            // Fallback if it's the final level of your game
            room_restart(); 
        }
    }
}