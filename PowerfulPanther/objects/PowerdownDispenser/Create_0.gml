// Ensure random numbers are different every time the game runs
randomise(); 

// --- Spawner Settings ---
// Room speed is typically 60 FPS. 
// So, 60 frames = 1 second.
min_spawn_time = 60;   // 1 second minimum wait
max_spawn_time = 180;  // 3 seconds maximum wait

// Start the timer cycle by setting Alarm 0 to a random frame count
alarm[0] = irandom_range(min_spawn_time, max_spawn_time);