package com.arc.varzea.engine {
	import com.arc.flixel.message.MessageSystem;
	import com.arc.varzea.util.Registry;
	
	import org.flixel.FlxBitmapFont;

	public class TextState extends GameState {
		private var shown:Boolean = false;
		private var text:String = "";
		private var font:FlxBitmapFont;
		
		public static var globalFont:FlxBitmapFont;
		
		public function TextState(font:FlxBitmapFont, text:String) {
			this.font = font;
			super();
			this.text = text;
		}
		
		override public function update():void {
			super.update();
			
			if (shown) {
				if (!MessageSystem.active) {
					Registry.engine.pop();
				}
				return;
			}
			
			TextState.globalFont = font;
			MessageSystem.dialog(text);
			shown = true;
		}
	}
}
