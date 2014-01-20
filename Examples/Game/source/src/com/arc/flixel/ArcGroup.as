package com.arc.flixel {
	//import com.arc.run.menu.Menu;
	import org.flixel.FlxBasic;
	import org.flixel.FlxBitmapFont;
	import org.flixel.FlxBitmapText;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	public class ArcGroup extends FlxGroup {
		protected var _alpha:Number = 1.0;
		public var x:Number = 0;
		public var y:Number = 0;
		
		public function ArcGroup(X:Number = 0, Y:Number = 0) {
			super();
			x = X;
			y = Y;
		}
		
		/**
		 * Sets the alpha of all children of this group to value
		 * @param	value	Alpha value to use
		 */
		public function set alpha(value:Number):void {
			_alpha = value;
			for each(var m:FlxBasic in members) {
				if (m is ArcGroup) {
					(m as ArcGroup).alpha = value;
				} else if (m is ArcSprite) {
					(m as ArcSprite).alpha = value;
				} else if (m is FlxBitmapText) {
					(m as FlxBitmapText).alpha = value;
				}
			}
		}
		
		public function get alpha():Number {
			return _alpha;
		}
		
		override public function add(Object:FlxBasic):FlxBasic {
			shift(Object, x, y);
			return super.add(Object);
		}
		
		public static function shift(Object:FlxBasic, X:Number, Y:Number):void {
			if (Object is FlxObject) {
				Object['x'] += X;
				Object['y'] += Y;
			} else if (Object is FlxGroup) {
				for each(var member:FlxBasic in (Object as FlxGroup).members) {
					shift(member, X, Y);
				}
			}
		}
	}
}
