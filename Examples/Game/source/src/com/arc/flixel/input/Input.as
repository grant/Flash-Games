package com.arc.flixel.input {
	import org.flixel.FlxG;

	/**
	 * Utility class to handle input.
	 */
	public class Input {
		/** Action => List of keys that perform that action */
		private static const KEY_MAP:Object = {
			"confirm" 	: ["Z", "Y", "SPACE", "A", "S", "D", "W"],
			"skip"		: ["ENTER"],
			"escape"	: ["ESCAPE"],
			"left"		: ["A", "LEFT"],
			"right"		: ["D", "RIGHT"],
			"down"		: ["S", "DOWN"],
			"up"		: ["W", "UP"],
			"jump"		: ["W", "UP", "SPACE"],
			"shoot"		: ["Q", "E"]
		};
		
		/**
		 * Returns whether or not a key corresponding to the passed action is being held down.
		 *  
		 * @param action the action to check
		 * @return whether or not it is being held
		 */		
		public static function held(action:String):Boolean {
			return checkKey("pressed", action);
		}
		
		/**
		 * Returns whether or not a key corresponding to the passed action was just pressed.
		 *  
		 * @param action the action to check
		 * @return whether or not it was just pressed
		 */	
		public static function pressed(action:String):Boolean {
			return checkKey("justPressed", action);
		}
		
		/**
		 * Loops over all keys for a given action and returns true if any of those keys are held/pressed.
		 * 
		 * @param func "pressed" or "justPressed"
		 * @param action the action to check
		 * @return whether the action is performing the passed function
		 */		
		private static function checkKey(func:String, action:String):Boolean {
			var isHeld:Boolean = false;
			for each(var k:String in KEY_MAP[action]) {
				isHeld ||= FlxG.keys[func](k);
			}
			return isHeld;
		}
		
		/**
		 * Reset the input, so that nothing is considered being down any longer.
		 */
		public static function reset():void {
			FlxG.keys.reset();
		}
	}
}