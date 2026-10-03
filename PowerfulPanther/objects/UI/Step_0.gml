// Increment frames every single step
game_frames++;

// Convert total frames into total seconds (assuming 60 FPS)
// game_get_speed(gamespeed_fps) reads your game's current framerate dynamically
total_seconds = game_frames / game_get_speed(gamespeed_fps);