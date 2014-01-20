package com.arc.varzea.resource {
	import org.flixel.FlxBitmapFont;

	public class Font {
		[Embed(source = "/fonts/font_outline_red.png")] private static const F_RED:Class;
		public static const RED:FlxBitmapFont = new FlxBitmapFont(F_RED, 0, 9, -1, -1, " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=_+[]{};':\",./<>?~!@#$%^&*()");
		
		[Embed(source = "/fonts/font_outline_gray.png")] private static const F_GRAY:Class;
		public static const GRAY:FlxBitmapFont = new FlxBitmapFont(F_GRAY, 0, 9, -1, -1, " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=_+[]{};':\",./<>?~!@#$%^&*()");
		
		[Embed(source = "/fonts/font_outline_gold.png")] private static const F_GOLD:Class;
		public static const GOLD:FlxBitmapFont = new FlxBitmapFont(F_GOLD, 0, 9, -1, -1, " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=_+[]{};':\",./<>?~!@#$%^&*()");
		
		[Embed(source = "/fonts/font_outline_green.png")] private static const F_GREEN:Class;
		public static const GREEN:FlxBitmapFont = new FlxBitmapFont(F_GREEN, 0, 9, -1, -1, " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=_+[]{};':\",./<>?~!@#$%^&*()");
		
		[Embed(source = "/fonts/font_outline_redtext.png")] private static const F_REDTEXT:Class;
		public static const REDTEXT:FlxBitmapFont = new FlxBitmapFont(F_REDTEXT, 0, 9, -1, -1, " ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=_+[]{};':\",./<>?~!@#$%^&*()");
	}
}
