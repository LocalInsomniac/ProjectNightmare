/// @description Transition Variables

enum eTransition {circle, circle2, fade}

transition = eTransition.circle;
reverse = false;
goto = noone;

surface = -1

timer_create();

//Update transition

global.clock.add_cycle_method(function ()
{
	if (timer_tick(0))
	{
		if !(reverse)
		{
			if (goto == noone)
			{
				game_end();
				exit
			}
	
			pn_level_goto(goto);
		}
		else instance_destroy();
	}
});