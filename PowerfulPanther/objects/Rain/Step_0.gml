// 1. TRACK THE CURRENT ACTIVE CAMERA VIEW BOUNDS
var _cam   = view_camera;
var _cam_x = camera_get_view_x(_cam);
var _cam_y = camera_get_view_y(_cam);
var _cam_w = camera_get_view_width(_cam);

// 2. STRETCH THE EMITTER RECTANGLE ACROSS THE TOP OF YOUR SCREEN
// We extend the width slightly (-100 to +100) so slanted rain doesn't leave blank gaps on the screen edges
var _left_bound   = _cam_x - 100;
var _right_bound  = (_cam_x + _cam_w) + 100;
var _top_spawn    = _cam_y - 20;
var _bottom_spawn = _cam_y - 10;

part_emitter_region(rain_system, rain_emitter, _left_bound, _right_bound, _top_spawn, _bottom_spawn, ps_shape_rectangle, ps_distr_linear);

// 3. DISPENSE THE PARTICLES
part_emitter_stream(rain_system, rain_emitter, rain_type, 8);