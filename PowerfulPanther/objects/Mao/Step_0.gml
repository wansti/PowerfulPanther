// 1. GET PLAYER INPUT (Updated)
var _key_left      = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _key_right     = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_jump      = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
var _key_jump_held = keyboard_check(vk_space) || keyboard_check(ord("W"));

var _move = _key_right - _key_left;


// 2. HORIZONTAL VELOCITY FORMULA (hsp)
if (_move != 0) 
{
    // SKIDDING: If pressing the opposite way of movement, apply a massive speed braking force
    if (sign(hsp) != 0 && sign(hsp) != _move)
    {
        hsp += _move * (acceleration * 2.5); // 2.5x braking force
    }
    else
    {
        hsp += _move * acceleration;
    }
    hsp = clamp(hsp, -walk_speed, walk_speed);
} 
else 
{
    // Apply heavy friction to stop instantly when keys are released
    if (hsp > 0) hsp = max(0, hsp - friction_val);
    if (hsp < 0) hsp = min(0, hsp + friction_val);
}


// 3. VERTICAL VELOCITY & COYOTE TIME FORMULA
var _grounded = place_meeting(x, y + 1, tilemap);

if (_grounded) 
{
    vsp = 0;
    coyote_timer = coyote_time_max; // Reset the cushion frames while on solid ground
} 
else 
{
    coyote_timer--; // Count down when in the air
    
    // APEX GRAVITY SCALING
    // If our vertical speed is close to 0 (the peak of the jump), dramatically reduce gravity
    var _current_grav = grav;
    if (abs(vsp) < apex_threshold) 
    {
        _current_grav = grav * apex_grav_mult;
    }
    
    // Apply calculated gravity
    vsp += _current_grav;
    vsp = min(vsp, term_vel);
}

// JUMP MECHANICS (Using Coyote Time)
// Instead of checking "_grounded", we check if our cushion timer is active
if (coyote_timer > 0) 
{
    if (_key_jump) 
    {
        vsp = jump_force; 
        coyote_timer = 0; // Consume the coyote frame instantly so you can't double jump
    }
}

// VARIABLE JUMP HEIGHT (Dampen jump if button is released early)
if (!_grounded && !_key_jump_held && vsp < 0) 
{
    vsp = max(vsp, jump_force * 0.35); 
}


// 4. OVERALL SPEED FORMULA
current_speed = point_distance(0, 0, hsp, vsp); 


// 5. COLLISION & POSITION UPDATE
// Horizontal Collision & Movement
if (place_meeting(x + hsp, y, tilemap)) 
{
    while (!place_meeting(x + sign(hsp), y, tilemap)) 
    {
        x += sign(hsp);
    }
    hsp = 0; // Stop horizontal velocity on collision
}
x += hsp; // Update X Position

// Vertical Collision & Movement
if (place_meeting(x, y + vsp, tilemap)) 
{
    while (!place_meeting(x, y + sign(vsp), tilemap)) 
    {
        y += sign(vsp);
    }
    vsp = 0; // Stop vertical velocity on collision
}
y += vsp; // Update Y Position