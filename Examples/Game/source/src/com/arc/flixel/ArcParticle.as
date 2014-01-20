package com.arc.flixel {
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class ArcParticle extends FlxSprite {
		public var lifetime:Number;
		private var lived:Number = 0;
		
		public function ArcParticle(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) {
			super(X, Y, SimpleGraphic);
		}
		
		override public function update():void {
			lived += FlxG.elapsed;
			if (lived > lifetime && visible) {
				alpha -= 0.02;
				if (alpha <= 0) {
					visible = false;
					lived = 0;
					alpha = 1;
				}
			}
			super.update();
		}
	}
}
