package com.arc.flixel {
	import org.flixel.*;
	
	public class ArcRect extends FlxRect {
		public function ArcRect(X:Number=0, Y:Number=0, Width:Number=0, Height:Number=0) {
			super(X, Y, Width, Height);
		}
		
		public function hover():Boolean {
			var mx:int = FlxG.mouse.screenX;
			var my:int = FlxG.mouse.screenY;
			return ( (mx > left) && (mx < right) ) && ( (my > top) && (my < bottom) );
		}
	}
}
