// 1. RENDER CONFIGURATIONS
draw_set_color(c_fuchsia); // Neon pink look for the bounce line

// 2. CONSTRUCT CURVED LINE SEGMENTS
// We calculate a curve by plotting points from start to the bending center, then down to the end
var _segments = 16;
var _prev_x = start_x;
var _prev_y = start_y;

for (var i = 1; i <= _segments; i++)
{
    // Linear Interpolation percentage along the line length
    var _t = i / _segments;
    
    // Calculate horizontal path
    var _curr_x = lerp(start_x, end_x, _t);
    
    // Use a sine wave calculation to shape a clean mathematical arch hanging down from current_bend
    var _curve_offset = sin(_t * pi) * current_bend;
    var _curr_y = lerp(start_y, end_y, _t) + _curve_offset;
    
    // Draw thick continuous pixel wire line segments
    draw_line_width(_prev_x, _prev_y, _curr_x, _curr_y, 4);
    
    // Store coordinates for next segment loop iteration
    _prev_x = _curr_x;
    _prev_y = _curr_y;
}

// Reset color cache for safety
draw_set_color(c_white);