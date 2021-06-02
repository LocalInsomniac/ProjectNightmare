/// @description cam_3d_enable()
function cam_3d_enable() {
	//Turns on the z-buffer
	gpu_set_zwriteenable(true);
	gpu_set_ztestenable(true);
	gpu_set_cullmode(cull_counterclockwise);
	gpu_set_texrepeat(true);


}
