// --- Physics Constants ---
grav       = 0.5;       // Heavy enough to fall smoothly
walk_speed = 2.5;       // Speed it wanders left/right
term_vel   = 8;         // Maximum falling speed

// --- Velocity Vectors ---
hsp = 0;
vsp = 0;

// --- State tracking ---
has_hit_ground = false; // Tracks if it has landed yet

// Custom angle variable that GameMaker's collision system ignores
visual_angle = 0; 