package com.arc.varzea.util {
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxPoint;

	public class Util {
		public static function d2v(direction:Number, speed:Number):FlxPoint {
			return new FlxPoint(speed * Math.cos(direction), speed * Math.sin(direction));
		}
		
		public static function v2d(velocity:FlxPoint):Number {
			return Math.atan2(velocity.y, velocity.x);
		}
		
		public static function r2d(radians:Number):Number {
			return radians * 180 / Math.PI;
		}
		
		public static function d2r(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		public static function p2c(position:Number):uint {
			return Math.floor(position / Tile.WIDTH);
		}
	}
}
