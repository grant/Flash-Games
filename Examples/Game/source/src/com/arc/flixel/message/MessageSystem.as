package com.arc.flixel.message {
	import org.flixel.FlxRect;

	public class MessageSystem {
		private static var box:MessageBox;
		
		{
			box = new MessageBox();
		}
		
		public static function show(position:FlxRect, message:String):void {
			message = message.toUpperCase();
			var messages:Vector.<String> = MessageSplitter.split(message, position.width - 48, position.height);
			while (messages.length > 0) {
				var msg:String = messages.shift();
				trace("\n\nGot Message:\n" + msg + "\n\n");
				box.push(new Message(position, msg));
			}
		}
		
		public static function dialog(message:String):void {
			show(new FlxRect(100, 100, 180, 44), message);
		}
		
		public static function update():void {
			box.update();
		}
		
		public static function draw():void {
			box.draw();
		}
		
		public static function get active():Boolean {
			return box.active;
		}
	}
}