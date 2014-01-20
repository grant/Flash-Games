package com.arc.flixel.message {
	import org.flixel.FlxRect;

	public class Message {
		public var message:String;
		public var position:FlxRect;
		
		public function Message(position:FlxRect, message:String) {
			this.position = position;
			this.message = message;
		}
	}
}