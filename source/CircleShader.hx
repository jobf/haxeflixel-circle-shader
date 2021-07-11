import flixel.FlxG;
import flixel.system.FlxAssets.FlxShader;

class CircleShader extends FlxShader
{
	@:glFragmentSource('
        #pragma header

		uniform vec2 screen_focus_pos;
		uniform bool useCircleALogic;
		float c;
		bool doShade;

		float circleA(in vec2 _st, in float _radius){
			vec2 dist = _st-vec2(0.5);
			return 1.-smoothstep(_radius-(_radius*0.01),
								_radius+(_radius*0.01),
								dot(dist,dist)*4.0);
		}		

		float circleB(vec2 position, float radius)
		{
			return smoothstep(radius, radius, length(position - vec2(0.5)));
		}

        void main()
        {
			if(useCircleALogic){
				c = circleA(openfl_TextureCoordv - (screen_focus_pos.xy / openfl_TextureSize.xy), 0.06);
				doShade = c > 0.0;
			}
			else{
				c = circleB(openfl_TextureCoordv - (screen_focus_pos.xy / openfl_TextureSize.xy), 0.12);
				doShade = !(c > 0.0);
			}

			if(doShade)
			{
				// use default frag color
				gl_FragColor = flixel_texture2D(bitmap, openfl_TextureCoordv);
			}
			else{
				// shader frag color
				vec4 color = vec4(0.5, 0.5, 0.5, 1.0);
				gl_FragColor = color;
			}
        }')
	public function new()
	{
		super();
		useCircleALogic.value = [true];
	}

	public function update_screen_focus_pos(x:Float, y:Float, w:Float, h:Float)
	{
		var offsetX = x - ((FlxG.width * 0.5) - (w * 0.5));
		var offsetY = y - ((FlxG.height * 0.5) - (h * 0.5));
		screen_focus_pos.value = [offsetX, offsetY];
	};

	public function toggle_circle_logic()
	{
		useCircleALogic.value[0] = !useCircleALogic.value[0];
	}
}
