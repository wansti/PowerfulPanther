tilemap = layer_tilemap_get_id("CollisionTiles");

// --- Movement Constants ---
walk_speed   = 4;        // Maximum horizontal speed
acceleration = 0.8;      // How fast you speed up
friction_val = 0.9;      // How fast you slow down
grav         = 0.6;      // Gravity strength
jump_force   = -11.5;     // Jump power
term_vel     = 12;       // Terminal velocity

// --- Velocity Vectors ---
hsp = 0;                 // Current horizontal velocity (vx)
vsp = 0;                 // Current vertical velocity (vy)
current_speed = 0;       // Speed magnitude

// --- New Game Feel Constants ---
coyote_time_max = 6;     // How many frames you can walk off a cliff and still jump
apex_threshold  = 1.5;   // vsp window close to 0 to trigger the jump peak (between -1.5 and 1.5)
apex_grav_mult  = 0.5;   // Gravity is cut in half at the peak for better landing control

// --- New Tracking Variables ---
coyote_timer = 0;        // Countdown timer for coyote frames