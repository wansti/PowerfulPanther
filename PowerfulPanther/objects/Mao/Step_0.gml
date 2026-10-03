// Decrease the control lock timer
if (wall_jump_lock_timer > 0) 
{
    wall_jump_lock_timer--;
}

// 1. CHOOSE YOUR DEVICE ID 
// Slot 0 is usually the primary connected controller (Xbox, PlayStation, or Switch)
var _slot = 0; 

// 2. CHECK KEYBOARD INPUTS (Existing)
var _key_left      = keyboard_check(vk_left)  || keyboard_check(ord("A"));
var _key_right     = keyboard_check(vk_right) || keyboard_check(ord("D"));
var _key_jump      = keyboard_check_pressed(vk_space) || keyboard_check_pressed(ord("W"));
var _key_jump_held = keyboard_check(vk_space) || keyboard_check(ord("W"));

// 3. CHECK GAMEPAD BUTTONS (D-Pad & Face Buttons)
var _pad_left      = gamepad_button_check(_slot, gp_padl);
var _pad_right     = gamepad_button_check(_slot, gp_padr);
var _pad_jump      = gamepad_button_check_pressed(_slot, gp_face1); // 'A' on Xbox / 'Cross' on PS
var _pad_jump_held = gamepad_button_check(_slot, gp_face1);

// 4. CHECK GAMEPAD ANALOG STICK (Left Thumbstick Horizontal Axis)
// Left stick axis returns a decimal value from -1.0 (all the way Left) to 1.0 (all the way Right)
var _axis_h = gamepad_axis_value(_slot, gp_axislh);

// Set a deadzone so a loose thumbstick doesn't make Mao slowly drift on his own
var _deadzone = 0.25;
var _stick_left  = (_axis_h < -_deadzone);
var _stick_right = (_axis_h > _deadzone);


// 5. COMBINE ALL INPUTS TOGETHER
// If ANY of these methods are true, the action triggers
var _final_left  = _key_left  || _pad_left  || _stick_left;
var _final_right = _key_right || _pad_right || _stick_right;

_key_jump      = _key_jump      || _pad_jump;
_key_jump_held = _key_jump_held || _pad_jump_held;

// OVERRIDE INPUTS IF CONTROL LOCKED
// If the timer is ticking down, force horizontal inputs to be false (0)
if (wall_jump_lock_timer > 0) 
{
    _final_left  = false;
    _final_right = false;
    // (If using analog stick, force _stick_left and _stick_right to false here too!)
}

// 6. CALCULATE FINAL MOVE DIRECTION
// Use the combined variables. The rest of your movement math stays exactly the same!
var _move = _final_right - _final_left;

var _layer_id = layer_get_id("CollisionTiles"); // Change to your Tile Layer name
var tilemap  = layer_tilemap_get_id(_layer_id);


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

// --- WALL JUMP LOGIC (ONLY TRIGGERS IN STATE 3) ---
// --- WALL JUMP LOGIC (ONLY TRIGGERS IN STATE 3) ---
if (state == 3) 
{    
    var _wall_left  = tilemap_get_at_pixel(tilemap, bbox_left - 2, y) || 
                      tilemap_get_at_pixel(tilemap, bbox_left - 2, bbox_bottom - 4);
                      
    var _wall_right = tilemap_get_at_pixel(tilemap, bbox_right + 2, y) || 
                      tilemap_get_at_pixel(tilemap, bbox_right + 2, bbox_bottom - 4);
    
    if (!_grounded && (_wall_left || _wall_right) && _key_jump) 
    {
        var _push_direction = _wall_left ? 1 : -1;
        
        vsp = jump_force * 0.9;            
        hsp = _push_direction * walk_speed * 1.5; // Kick away explosively
        
        // TRIGGER CONTROL LOCK
        // Freezes the player's ability to steer backward for 12 frames
        wall_jump_lock_timer = 20; 
    }
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

// Sprite selection
// 1. CHOOSE THE RIGHT SPRITE BASED ON VELOCITY VECTORS
if (_grounded)
{
    if (hsp != 0)
    {
        // Player is moving left or right on the ground
        sprite_index = MaoRunning;  // Change to your running sprite asset name
    }
    else
    {
        // Player is standing completely still
        sprite_index = MaoSmall; // Change to your idle sprite asset name
    }
}
else
{
    // Player is in mid-air (jumping or falling)
    if (vsp < 0)
    {
        sprite_index = MaoRunning; // Rising up
    }
    else
    {
        sprite_index = MaoRunning; // Falling down
    }
}


// 2. FLIP THE SPRITE HORIZONTALLY TO FACE MOVEMENT DIRECTION
// Using image_xscale = 1 draws the sprite normally (facing right)
// Using image_xscale = -1 mirrors the sprite (facing left)
if (hsp != 0)
{
    image_xscale = sign(hsp); 
}