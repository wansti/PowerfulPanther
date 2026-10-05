// --- Timer Variables ---
game_frames = 0;    // Tracks individual elapsed frames
total_seconds = 0;  // Total seconds passed

if (!audio_is_playing(BGMusic)) 
{
    // Play the audio track
    // Arguments: (index, priority, loop)
    // Priority: '10' ensures your music won't get cut off if too many sound effects play at once
    // Loop: 'true' makes the track seamlessly start over from the beginning when it finishes
    audio_play_sound(BGMusic, 10, true);
}

// --- Global Underworld Return Anchors ---
global.saved_x = 0;
global.saved_y = 0;
global.saved_room = Room1; // Tracks which level Mao came from
global.was_in_yarn = false; // Flag to tell the game to restore position

window_set_fullscreen(true);