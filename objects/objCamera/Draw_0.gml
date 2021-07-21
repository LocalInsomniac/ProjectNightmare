/// @description Render Game
var _yaw, _pitch, _roll, _x, _y, _z;
if (fSmooth)
{
	_yaw = yaw_smooth;
	_pitch = pitch_smooth;
	_roll = roll_smooth;
	_x = x_smooth;
	_y = y_smooth;
	_z = z_smooth;
}
else
{
	_yaw = yaw;
	_pitch = pitch;
	_roll = roll;
	_x = x;
	_y = y;
	_z = z;
}

var yawFactorX = dcos(_yaw), yawFactorY = -dsin(_yaw);
cam_set_viewmat(view_camera[0], _x, _y, _z, _x + yawFactorX, _y + yawFactorY, _z + dtan(clamp(_pitch, -89.95, 89.95)), 0, 0, 1);
cam_set_projmat(view_camera[0], fov, 16/9, 1, 65536);
camera_apply(view_camera[0]);

draw_set_color(c_white);
var time = current_time * 0.001;

//Textured skybox

if (global.skybox[0] == noone) draw_clear(global.skyboxColor);
else
{
	global.currentShader = shSkybox;
	shader_set(shSkybox);
	shader_set_uniform_f(global.shaderUniforms[eShader.skybox][eSkyboxShaderUniform.time], time);
	gpu_set_zwriteenable(false);
	matrix_set(matrix_world, matrix_build(_x + yawFactorX, _y + yawFactorY, _z, 0, 0, 0, 1, 1, 1));
	smf_model_draw(global.skybox[1], pn_material_get_texture(global.skybox[0]));
	gpu_set_zwriteenable(true);
}

global.currentShader = shWorld;
shader_set(shWorld);

shader_set_uniform_f(global.shaderUniforms[eShader.world][eWorldShaderUniform.fogStart], global.fogDistance[0]);
shader_set_uniform_f(global.shaderUniforms[eShader.world][eWorldShaderUniform.fogEnd], global.fogDistance[1]);
shader_set_uniform_f(global.shaderUniforms[eShader.world][eWorldShaderUniform.fogColor], global.fogColor[0], global.fogColor[1], global.fogColor[2], global.fogColor[3]);
shader_set_uniform_f(global.shaderUniforms[eShader.world][eWorldShaderUniform.lightDirection], global.lightNormal[0], global.lightNormal[1], global.lightNormal[2]);
shader_set_uniform_f(global.shaderUniforms[eShader.world][eWorldShaderUniform.lightColor], global.lightColor[0], global.lightColor[1], global.lightColor[2], global.lightColor[3]);
shader_set_uniform_f(global.shaderUniforms[eShader.world][eWorldShaderUniform.lightAmbientColor], global.lightAmbientColor[0], global.lightAmbientColor[1], global.lightAmbientColor[2], global.lightAmbientColor[3]);
shader_set_uniform_f(global.shaderUniforms[eShader.world][eWorldShaderUniform.time], time);

//Level
var roomData = global.levelData[? global.levelRoom];
if !(is_undefined(roomData))
{
	var roomModel = roomData[eRoomData.model];
	if !(is_undefined(roomModel))
	{
		var i = 0;
		repeat (array_length(roomModel))
		{
			var getSubmodel = roomModel[i], material = getSubmodel[eModelData.material];
			if (is_undefined(material)) continue //Don't draw invisible submodels
			vertex_submit(getSubmodel[eModelData.submodel], pr_trianglelist, pn_material_get_texture(material));
			i++;
		}
	}
}

//Actors farthest to nearest (fixes alpha blending issues)

with (objActor) if (fVisible) ds_priority_add(other.renderPriority, self, point_distance_3d(other.x, other.y, other.z, x, y, z));

repeat (ds_priority_size(renderPriority))
{
	ds_priority_find_max(renderPriority).draw();
	ds_priority_delete_max(renderPriority);
}

smf_matrix_reset();
shader_reset();