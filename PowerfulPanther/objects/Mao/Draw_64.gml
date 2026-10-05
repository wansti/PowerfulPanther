// --- RENDER SECRET CORNER MESSAGE ---
if (show_corner_message && (room != YarnRoom))
{
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    // 1. POSITION CALCULATIONS (Locks it exactly to the middle-center of the player's monitor)
    var _text_x = _gui_w / 2;
    var _text_y = _gui_h / 2;
    
    // 2. TEXT STYLE DECORATIONS
    draw_set_font(-1); // Uses default font (or replace with your fnt_large_ui)
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var _message_string = "NO, IT'S NOT A WARP ZONE";
    var _font_scale = 2.5; // Resizes the font size smoothly using our previous transformation math
    
    // 3. DRAW THE TEXT WITH A DROP-SHADOW FOR HIGHER CONTRAST AGAINST BACKGROUND TILES
    // Shadow (offset down and right by 2 pixels)
    draw_set_color(c_black);
    draw_text_transformed(_text_x + 2, _text_y + 2, _message_string, _font_scale, _font_scale, 0);
    
    // Foreground Text
    draw_set_color(c_yellow); // Using bright arcade yellow so it pops
    draw_text_transformed(_text_x, _text_y, _message_string, _font_scale, _font_scale, 0);
    
    // 4. RESET ALIGNMENT FOR ENGINE SAFETY
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}