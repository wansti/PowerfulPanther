if (level_complete) 
{
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    var _center_x = _gui_w / 2;
    var _center_y = _gui_h / 2;
    
    // 1. DRAW A DARK BACKDROP DIMMER
    // This darkens the gameplay screen slightly so the text pops out prominently
    draw_set_color(c_black);
    draw_set_alpha(0.65); // 65% opacity
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0); // Reset alpha back to normal
    
    // 2. CONFIGURE LARGE TEXT DESIGN
    draw_set_font(-1); // Uses default font (scales via draw_text_transformed)
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    // 3. DRAW "STAGE CLEAR" TITLE
    // Arguments: (x, y, string, xscale, yscale, angle)
    draw_set_color(c_black);
    draw_text_transformed(_center_x + 3, _center_y - 50 + 3, "STAGE CLEAR!", 3, 3, 0); // Shadow
    draw_set_color(c_yellow);
    draw_text_transformed(_center_x, _center_y - 50, "STAGE CLEAR!", 3, 3, 0); // Foreground
    
    // 4. DRAW THE FINAL TIME
    var _display_text = "FINAL TIME: " + final_time_string;
    
    draw_set_color(c_black);
    draw_text_transformed(_center_x + 2, _center_y + 20 + 2, _display_text, 2, 2, 0); // Shadow
    draw_set_color(c_white);
    draw_text_transformed(_center_x, _center_y + 20, _display_text, 2, 2, 0); // Foreground
    
    // 5. RESET ALIGNMENT ASSETS FOR SAFETY
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}