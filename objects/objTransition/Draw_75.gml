/// @description Draw Transition

var width = camera_get_view_width(view_camera[0])
var height = camera_get_view_height(view_camera[0])

if !(surface_exists(surface)) surface = surface_create(width, height);

surface_set_target(surface);

// Clear the Z-buffer. The transition won't work in a 3D world otherwise.
draw_clear_alpha(c_white, 0)

switch (transition)
{
	case (eTransition.circle):
		var radius = (reverse ? timer[0] : (60 - timer[0])) / 60.0 * width

		draw_set_color(c_black);
		draw_circle(width * 0.5, height * 0.5, radius, false);
		draw_set_color(c_white);
		break
	case (eTransition.circle2):
		var radius = (reverse ? (60 - timer[0]) : timer[0]) / 60.0 * width

		draw_set_color(c_black);
		draw_rectangle(0, 0, width, height, false);
		draw_set_color(c_white);
		gpu_set_blendmode(bm_subtract);
		draw_circle(width * 0.5, height * 0.5, radius, false);
		gpu_set_blendmode(bm_normal);
		break
	case (eTransition.fade):
		draw_set_color(c_black);
		draw_set_alpha((reverse ? timer[0] : (120 - timer[0])) / 120);
		draw_rectangle(0, 0, width, height, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		break
}

surface_reset_target();

draw_surface(surface, 0, 0)
