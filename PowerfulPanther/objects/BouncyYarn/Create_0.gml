// --- Line Boundary Anchors (Pixels) ---
// Note: You can change these to control how wide the line is
line_length = 256;
start_x = x;
start_y = y;
end_x   = x + line_length;
end_y   = y;

// --- Physics & Elasticity Constants ---
stiffness = 0.12;   // Tension coefficient (higher = stiffer trampoline)
damping   = 0.88;   // Friction loss (keeps it from bouncing infinitely)
bounce_force = -11; // Upward vsp vector boost given to Mao on launch

// --- Wave / Bend Variables ---
center_y      = y;  // Rest position of the middle of the line
current_bend  = 0;  // Current offset of the line's center point
bend_velocity = 0;  // Momentum of the rubber line elastic band