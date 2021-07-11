package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import openfl.filters.ShaderFilter;

class PlayState extends FlxState
{
	var player:FlxSprite;
	var shader:CircleShader;
	var speed = 50;

	override public function create()
	{
		super.create();

		player = new FlxSprite();
		player.makeGraphic(16, 16);
		add(player);

		shader = new CircleShader();
		FlxG.camera.setFilters([new ShaderFilter(shader)]);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		shader.update_screen_focus_pos(player.x, player.y, player.width, player.height);

		player.velocity.x = 0;
		player.velocity.y = 0;

		if (FlxG.keys.justPressed.ENTER)
		{
			shader.toggle_circle_logic();
		}

		if (FlxG.keys.pressed.LEFT)
		{
			player.velocity.x -= speed;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			player.velocity.x += speed;
		}
		if (FlxG.keys.pressed.UP)
		{
			player.velocity.y -= speed;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			player.velocity.y += speed;
		}
	}
}
