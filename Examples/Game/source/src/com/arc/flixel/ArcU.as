package com.arc.flixel {
	import org.flixel.FlxU;
	
	public final class ArcU {
		public static function rand(min:int, max:int):int {
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}
		
		public static function abs(n:Number):Number {
			if (n < 0) n = -n;
			return n;
		}
		
		public static function clamp(value:Number, min:Number, max:Number):Number {
			if (value > max) return max;
			if (value < min) return min;
			return value;
		}
		
		public static function duration(start:int, end:int, includeHours:Boolean = true):String {
			var dx:int = Math.ceil(end - start);
			var seconds:Number = dx % 60;
			dx /= 60;
			var minutes:Number = dx % 60;
			dx /= 60
			var hours:Number = dx;
			
			return	(includeHours ? ((hours < 10 ? "0" + hours : hours.toString()) + ":") : "") +
				(minutes < 10 ? "0" + minutes : minutes.toString()) + ":" +
				(seconds < 10 ? "0" + seconds : seconds.toString());
		}
	}
}
