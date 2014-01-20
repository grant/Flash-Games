package com.arc.flixel.message {
	import com.arc.varzea.resource.Font;
	
	import flash.text.FontStyle;
	
	import org.flixel.FlxBitmapText;

	public class MessageSplitter {
		private static const FONT_HEIGHT:uint = 9;
		private static const FONT_SPACING:uint = 1;
		
		public static function split(str:String, width:uint, height:uint):Vector.<String> {
			trace("width", width);
			var numLines:uint = lineCount(height);
			
			var messages:Vector.<String> = new Vector.<String>;
			var lines:Array = getLines(str, width);
			
			var currentSet:Vector.<String> = new Vector.<String>;
			for each(var line:String in lines) {
				currentSet.push(line);
				if (currentSet.length == numLines) {
					messages.push(currentSet.join("\n"));
					currentSet = new Vector.<String>;
				}
			}
			
			if (currentSet.length > 0) {
				messages.push(currentSet.join("\n"));
			}
			
			return messages;
		}
		
		private static function lineCount(height:uint):uint {
			var remainingHeight:int = height - 8;
			var numLines:uint = 0;
			while (remainingHeight > 0) {
				trace(remainingHeight);
				numLines++;
				remainingHeight -= FONT_HEIGHT + FONT_SPACING;
			}
			
			return numLines;
		}
		
		private static function getLines(str:String, width:uint):Array {
			var splitter:FlxBitmapText = new FlxBitmapText(0, 0, Font.GRAY, str, "left", width);
			return splitter.lines;
		}
	}
}