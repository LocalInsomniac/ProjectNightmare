/// @description Create Camera
event_inherited();
audio_emitter_free(emitter);

fCollision = false;
fGravity = false;
fVisible = false;

fov = 45;
target = objPlayer;
defaultRange = 80;

range = defaultRange;

renderPriority = ds_priority_create();

cam_3d_enable();
cam_set_projmat(view_camera[0], fov, 16/9, 1, 65536);
camera_apply(view_camera[0]);

tick = function ()
{
	if !(instance_exists(target)) exit
	
	//TODO: Customizable mouselook sensitivity
	if (input_player_source_get() == INPUT_SOURCE.GAMEPAD) //Controller
	{
	    if !(global.lockPlayer)
	    {
	        yaw += (input_check(eBind.cameraLeft) - input_check(eBind.cameraRight)) * 2.5;
	        pitch = clamp(pitch + (input_check(eBind.cameraUp) - input_check(eBind.cameraDown)) * 2.5, -89.95, 89.95);
	    }
	}
	else if (window_has_focus()) //Mouse (hard-coded, why would you want to move the camera with keys anyway?)
	{
	    var gW = window_get_x() + window_get_width() * 0.5, gH = window_get_y() + window_get_height() * 0.5;
	    if !(global.lockPlayer)
	    {
	        yaw -= (display_mouse_get_x() - gW) / 2.5;
	        pitch = clamp(pitch - ((display_mouse_get_y() - gH) / 2.5), -89.95, 89.95);
	    }
	    display_mouse_set(gW, gH);
	}
	
	var targetCenter = target.z + 8 + target.height * 0.5, targetRange = defaultRange, getRoom = global.levelData[? global.levelRoom];
	if (!is_undefined(getRoom) && !is_undefined(getRoom[eRoomData.collision]))
	{
		var i = 0;
		repeat (array_length(getRoom[eRoomData.collision]))
		{
			var collision = getRoom[eRoomData.collision][i];
			if !(collision[eCollisionData.active]) continue
			
			var mesh = collision[eCollisionData.mesh];
			collision = mesh.castRay(target.x, target.y, targetCenter, target.x - lengthdir_x(lengthdir_x(defaultRange, yaw), pitch), target.y - lengthdir_x(lengthdir_y(defaultRange, yaw), pitch), target.z + lengthdir_y(defaultRange, pitch));
			if (is_array(collision)) targetRange = point_distance_3d(target.x, target.y, targetCenter, collision[0], collision[1], collision[2]);
			
			i++;
		}
	}
	
	range = lerp(range, targetRange, 0.2);
	x = target.x - lengthdir_x(lengthdir_x(range, yaw), pitch);
	y = target.y - lengthdir_x(lengthdir_y(range, yaw), pitch);
	z = targetCenter + lengthdir_y(range - 8, pitch);
	
	baseTick();
}