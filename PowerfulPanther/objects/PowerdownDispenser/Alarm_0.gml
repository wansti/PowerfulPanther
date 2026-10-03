// 1. CALCULATE RANDOM X COORDINATE
// Spawns within the room boundaries, leaving a 32-pixel safety margin on the left/right edges
var _padding = 32;
var _random_x = irandom_range(_padding, room_width - _padding);

// 2. SPAWN THE OBJECT
// Replace 'obj_enemy' with the actual asset name of the object you want to spawn
// 'y' is the vertical position of this spawner object in your room
instance_create_layer(_random_x, 0, "Instances", Powerdown);

// 3. RESET THE RANDOM TIMER LOOP
// Pick a new random time and start counting down again
alarm[0] = irandom_range(min_spawn_time, max_spawn_time);