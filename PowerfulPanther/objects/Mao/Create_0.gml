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