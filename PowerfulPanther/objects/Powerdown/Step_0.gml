// 1. GET THE TILEMAP ID FOR COLLISIONS
var _layer_id = layer_get_id("CollisionTiles"); // Change to your Tile Layer name
var _tilemap  = layer_tilemap_get_id(_layer_id);

// 2. APPLY VERTICAL VELOCITY (Gravity)
vsp += grav;
vsp = min(vsp, term_vel);


// 3. GROUND DETECTION & RANDOM DIRECTION FORMULA
// Check if a tile exists 1 pixel below the powerup
var _bbox_side_y = (vsp >= 0) ? bbox_bottom : bbox_top;
var _tile_below  = tilemap_get_at_pixel(_tilemap, bbox_left, bbox_bottom + 5) || 
                   tilemap_get_at_pixel(_tilemap, bbox_right, bbox_bottom + 5);

if (_tile_below) 
{
    // The moment it hits the ground for the very first time
    if (!has_hit_ground) 
    {
        has_hit_ground = true;
        
        // Pick a random direction: -1 (Left) or 1 (Right)
        // choose() randomly selects one of the arguments provided
        var _random_dir = choose(-1, 1); 
        hsp = _random_dir * walk_speed;
    }
    vsp = 0; // Stop falling
}


// 4. WALL BOUNCING MECHANIC
// If walking left/right and it hits a wall tile, instantly reverse horizontal direction
var _check_x = (hsp > 0) ? bbox_right + hsp : bbox_left + hsp;
if (tilemap_get_at_pixel(_tilemap, _check_x, bbox_top) || 
    tilemap_get_at_pixel(_tilemap, _check_x, bbox_bottom)) 
{
    hsp = -hsp; // Invert velocity vector (bounce)
}


// 5. UPDATE POSITION
x += hsp;
y += vsp;


// 6. PLAYER PICKUP MECHANIC
// Check for a collision with your player object (replace obj_player with your asset name)
if (place_meeting(x, y, Mao)) 
{
    // --- Trigger Powerup Effect Here ---
    // Example: obj_player.walk_speed = 6; (Speed boost!)
    Mao.state += choose(-1, 1);
	if (Mao.state < 0)
	{
		Mao.state = 3;
	}
	else if (Mao.state > 3)
	{
		Mao.state = 0;
	}
	
    // Destroy this instance so it can't be picked up again
    instance_destroy(); 
}

if (hsp != 0)
{
		// Spin the visual angle, completely safe from wall collisions
		if (hsp < 0)
		{
			visual_angle += 3;
		}
		else if (hsp > 0)
		{
			visual_angle -= 3;
		}

		// Keep the value safely bounded between 0 and 360
		if (visual_angle < 0) visual_angle += 360;
}

// Rotates the sprite clockwise by 2 degrees every frame
//image_angle -= 2; 
// Keep the angle bounded between 0 and 360 to prevent memory bloating over time
//if (image_angle < 0) image_angle += 360;