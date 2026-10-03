// 1. CREATE THE PARTICLE SYSTEM
// This system acts as the canvas for our rain
rain_system = part_system_create();
part_system_depth(rain_system, -100); // Place it in front of background layers but behind UI

// 2. DEFINE THE DROPLET TYPE
rain_type = part_type_create();
part_type_sprite(rain_type, MaoSmall, false, false, false); // Fallback to built-in pixel or assign custom asset
part_type_shape(rain_type, pt_shape_line);                      // Creates a clean, fast streak line
part_type_size(rain_type, 0.1, 0.2, 0, 0);                      // Tiny, thin raindrops
part_type_color1(rain_type, c_teal);                            // Translucent blue/teal hue
part_type_alpha2(rain_type, 0.6, 0.2);                          // Fades out slightly as it hits the ground

// 3. PHYSICAL MOVEMENT FORMULAS
part_type_speed(rain_type, 10, 14, 0, 0);                      // Falling velocity range
part_type_direction(rain_type, 250, 260, 0, 0);                // Slanted downward angle (270 is straight down)
part_type_life(rain_type, 40, 60);                             // How many frames a droplet exists before disappearing

// 4. ROTATION & ALIGNMENT FORMULA
// Arguments: (ind, min_angle, max_angle, angle_increase, angle_wiggle, relative)
// Setting 'relative' (the final argument) to true locks the graphic rotation directly to its movement vector
part_type_orientation(rain_type, 0, 0, 0, 0, true);

// 4. THE EMITTER (The dispenser)
rain_emitter = part_emitter_create(rain_system);