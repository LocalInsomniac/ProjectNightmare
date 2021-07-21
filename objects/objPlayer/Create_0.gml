/// @description Create Player
event_inherited();

sprite = "sprFairy";
frameSpeed = 0.075;

tick = function()
{
	if (fOnGround && input_check_pressed(eBind.jump)) zSpeed = 5;
	
	baseTick();
}