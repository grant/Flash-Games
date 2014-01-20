package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Font;
	
	import org.flixel.FlxBitmapText;
	import org.flixel.FlxG;

	public class DamageText extends FlxBitmapText {
		private var lifetime:Number = 1;
		
		public function DamageText(x:Number, y:Number, amount:String) {
			super(x - 100, y, Font.RED, amount, "center", 200);
			velocity.y = -100;
			velocity.x = ArcU.rand(-50, 50);
			acceleration.y = 200;
		}
		
		override public function update():void {
			lifetime -= FlxG.elapsed;
			if (lifetime <= 0) {
				kill();
			}
		}
	}
}
