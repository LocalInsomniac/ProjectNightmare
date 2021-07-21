function pn_input_pressed_any()
{
	var bind = input_check_press_most_recent();
	return (!is_undefined(bind) && input_check_pressed(bind))
}

function pn_input_center_mouse() { if (window_has_focus() && input_player_source_get() == INPUT_SOURCE.GAMEPAD) display_mouse_set(window_get_x() + window_get_width() * 0.5, window_get_y() + window_get_height() * 0.5); }