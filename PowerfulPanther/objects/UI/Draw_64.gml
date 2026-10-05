// show timer
// 1. CALCULATE TIME FORMAT (MM:SS)
var _minutes = floor(total_seconds / 60);
var _seconds = floor(total_seconds mod 60);
var _font_scale = 2;

// Format numbers into strings with a leading zero if they are single digits
var _str_mins = (_minutes < 10) ? "0" + string(_minutes) : string(_minutes);
var _str_secs = (_seconds < 10) ? "0" + string(_seconds) : string(_seconds);
var _time_string = _str_mins + ":" + _str_secs;


// 2. SET UP UI TEXT ALIGNMENT & DESIGN
draw_set_font(-1); // Uses default GameMaker font (replace with your font asset if you have one)
draw_set_halign(fa_center); // Align text from the center
draw_set_valign(fa_top);


// 3. DRAW THE TIMER TEXT
// We place it at the top-center of the player's GUI window
var _gui_x = display_get_gui_width() / 2;
var _gui_y = 20;

// Drop shadow effect for readability against bright background tiles
draw_set_color(c_black);
draw_text_transformed(_gui_x + 2, _gui_y + 2, _time_string, _font_scale, _font_scale, 0);

// Foreground main text
draw_set_color(c_white);
draw_text_transformed(_gui_x, _gui_y, _time_string, _font_scale, _font_scale, 0);


// 4. RESET ALIGNMENT (Best practice so it doesn't break other UI elements)
draw_set_halign(fa_left);


// show player state
// 1. CHOOSE AN ANCHOR POSITION ON THE SCREEN
// Places it in the top-left corner of the monitor screen
var _ui_x = 20;
var _ui_y = 20;

// 2. CHECK IF MAO ACTUALLY EXISTS IN THE ROOM
// This prevents the game from crashing if Mao gets destroyed or hasn't spawned yet
if (instance_exists(Mao)) 
{
    // 3. PULL THE STATE VARIABLE USING DOT NOTATION
    // Converted to a string so it displays text perfectly
    var _state_text = "STATE: ";
	switch (Mao.state)
	{
		case 0: _state_text += "SMALL"; break;
		case 1: _state_text += "FAST!"; break;
		case 2: _state_text += "BIG"; break;
		case 3: _state_text += "WALL JUMP!"; break;
	}


    
    // 4. DRAW THE TEXT
    draw_set_font(-1); // Uses default font
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    // Drop shadow for readability
    draw_set_color(c_black);
    draw_text_transformed(_ui_x + 1, _ui_y + 1, _state_text, _font_scale, _font_scale, 0);
    
    // Main text
    draw_set_color(c_lime); // Using bright lime green so it stands out
	draw_text_transformed(_ui_x, _ui_y, _state_text, _font_scale, _font_scale, 0);
}