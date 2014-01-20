package com.arc.varzea.ui {
	import com.arc.flixel.ArcSprite;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	
	import org.flixel.FlxG;

	public class HeartBar extends ArcSprite {
		public function HeartBar() {
			loadGraphic(Resource.HEART, true, false, 11, 11);
		}
		
		override public function update():void {
			super.update();
		}
		
		override public function draw():void {
			var center:int = FlxG.width / 2;
			var hearts:int = Registry.maxHP();
			var width:int = 10 * hearts + 1;
			
			y = 229;
			frame = 0;
			for (var i:uint = 0; i < hearts; i++) {
				x = center - width / 2 + i * 10;
				
				if (Registry.hp < i + 1) {
					frame = 1;
				}
				
				super.draw();
			}
		}
	}
}
