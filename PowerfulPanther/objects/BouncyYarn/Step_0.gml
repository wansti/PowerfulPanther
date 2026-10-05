// 1. HOOKE'S LAW SPRING FORMULA SIMULATION
// Calculates spring displacement tension pulling back toward rest position (center_y)
var _displacement = center_y - (y + current_bend);
var _spring_force = _displacement * stiffness;

// Accumulate acceleration momentum and damp it over time
bend_velocity += _spring_force;
bend_velocity *= damping;
current_bend  += bend_velocity;


// 2. MAO INTERACTION & REBOUND DETECTION
if (instance_exists(Mao))
{
    // Check if Mao's feet coordinates intersect horizontally with the line segment
    if (Mao.x >= start_x && Mao.x <= end_x)
    {
        // Check if Mao is falling DOWNWARD and is breaking through the current line height threshold
        if (Mao.vsp > 0 && Mao.bbox_bottom >= (y + current_bend) && Mao.bbox_bottom <= (y + current_bend) + 12)
        {
            // Lock Mao pixel-perfectly to the line to prevent falling through
            Mao.y = (y + current_bend) - (Mao.bbox_bottom - Mao.y);
            
            // Push the line downwards under Mao's heavy impact vector
            bend_velocity = Mao.vsp * 1.5;
            
            // LAUNCH FORMULA: If player is holding Jump, launch super high, otherwise do a normal bounce
            var _jump_held = keyboard_check(vk_space) || keyboard_check(ord("W")); // Include gamepad flags if needed
            
            if (_jump_held)
            {
				audio_play_sound(SndJump, 5, false); 
                Mao.vsp = bounce_force * 1.4; // 40% Super Trampoline Boost!
            }
            else
            {
                Mao.vsp = bounce_force; // Standard Spring Rebound Vector
            }
            
            // Set Mao's state safely to allow air control recovery
            if (Mao.state == 1) Mao.state = 0; 
        }
    }
}