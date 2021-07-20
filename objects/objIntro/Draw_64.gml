/// @description Draw Intro
draw_set_font(pn_font_get_font("fntMario"));
if (state < 7)
{
	var dir = get_timer() / 900, w = wobble * 0.04;
	if (image_xscale_smooth > 0) draw_sprite_ext(pn_sprite_get_sprite("sprLogo"), 0, 480, 270, 2 * (image_xscale_smooth + lengthdir_x(w, dir)), 2 * (image_xscale_smooth + lengthdir_y(w, dir)), 0, c_white, 1);
	draw_set_halign(fa_center);
	draw_set_alpha(image_alpha_smooth);
	draw_set_color(c_white);
	draw_text(480, 398, "EARLY DEMO");
	draw_set_alpha(1);
	draw_set_halign(fa_left);
}
else
{
	draw_set_halign(fa_center);
	draw_set_alpha(image_alpha_smooth);
	draw_set_color(c_white);
	draw_text_transformed(480, 64, "DISCLAIMER", 2, 2, 0);
	draw_set_valign(fa_center);
	draw_set_font(pn_font_get_font("fntMessage"));
	draw_text_ext_transformed(480, 300, "This is an UNOFFICIAL, NON-PROFIT fan game.\nWe do not hold any copyrights.\n\nMario, Zelda & other related series (c) Nintendo\nFMOD (c) Firelight Technologies\n\nPowered by PN Engine\n\nThank you for playing!\n-Team Nightmare", -1, 480, 2, 2, 0);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}