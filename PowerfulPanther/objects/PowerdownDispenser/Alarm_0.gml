// 1. GET THE CURRENT ACTIVE CAMERA BOUNDS
var _cam   = view_camera[0];
var _cam_x = camera_get_view_x(_cam); // The current left edge of the screen
var _cam_w = camera_get_view_width(_cam); // The width of the visible screen

// 2. CALCULATE A RANDOM X COORDINATE INSIDE THE SCREEN
// Spawns within the camera view, leaving a 32-pixel safety margin on the left/right screen edges
var _padding   = 32;
var _min_spawn = _cam_x + _padding;
var _max_spawn = (_cam_x + _cam_w) - _padding;
var _random_x  = irandom_range(_min_spawn, _max_spawn);

// 3. SPAWN THE OBJECT
// Replace 'obj_enemy' with the actual asset name of the object you want to spawn
// 'y' is the vertical position of this spawner object in your room
instance_create_layer(_random_x, 0, "Instances", Powerdown);

// 4. RESET THE RANDOM TIMER LOOP
// Pick a new random time and start counting down again
alarm[0] = irandom_range(min_spawn_time, max_spawn_time);