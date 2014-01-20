package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.util.Registry;
	
	import org.flixel.FlxBitmapText;
	import org.flixel.FlxG;
	
	public class LevelUpText extends FlxBitmapText {
		private var lifetime:Number = 2;
		
		public function LevelUpText() {
			super(Registry.world.player.getMidpoint().x - 100, Registry.world.player.getMidpoint().y - 16, Font.GREEN, "LEVEL UP", "center", 200);
			velocity.y = -30;
		}
		
		override public function update():void {
			lifetime -= FlxG.elapsed;
			if (lifetime <= 0) {
				kill();
			}
		}
	}
}
