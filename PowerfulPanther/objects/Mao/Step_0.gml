// 1. GET PLAYER INPUT
var _key_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _key_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_jump  = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
var _key_jump_held = keyboard_check(vk_space) || keyboard_check(ord("W"));

// Calculate input direction (-1 for Left, 1 for Right, 0 for Idle)
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


// 3. VERTICAL VELOCITY FORMULA (vsp)
// Check if touching the solid ground object (replace obj_solid with your ground wall)
var _grounded = place_meeting(x, y + 1, tilemap);

// Apply gravity if in the air
if (!_grounded) 
{
    vsp += grav;
    vsp = min(vsp, term_vel); // Clamp to terminal velocity
} 
else 
{
    vsp = 0; // Reset vertical velocity on the ground
    
    // Jump mechanics
    if (_key_jump) 
    {
        vsp = jump_force; 
    }
}

// VARIABLE JUMP HEIGHT (Removes floaty airtime if tapping the button)
if (!_grounded && !_key_jump_held && vsp < 0) 
{
    vsp = max(vsp, jump_force * 0.35); // Instantly dampens upward velocity by 65%
}

// 4. OVERALL SPEED FORMULA (Magnitude)
// This calculates total speed using the Pythagorean theorem formula: sqrt(hsp^2 + vsp^2)
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