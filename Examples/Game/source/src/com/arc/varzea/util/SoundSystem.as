package com.arc.varzea.util {
	import com.arc.flixel.ArcSfxr;
	import com.arc.flixel.ArcU;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	
	public class SoundSystem {
		public static var playing:Class;
		public static var wasPlaying:FlxSound;
		public static var playingVolume:Number;
		
		public static function music(resource:Class, volume:Number = 1.0, start:Number = 0.0):void {
			if (playing != resource) {
				if (Registry.music == Registry.ON) {
					if (playing != null) {
						/*
						if (wasPlaying != null && wasPlaying.active) {
							wasPlaying.stop();
						}
						wasPlaying = FlxG.music;
						wasPlaying.fadeOut(2);
						FlxG.music = null;*/
						FlxG.music.stop();
						FlxG.music = null;
					}
					FlxG.playMusic(resource, volume);
					FlxG.music.fadeIn(2);
				}
				playing = resource;
				playingVolume = volume;
			}
		}
		
		public static function update():void {
			if (wasPlaying != null && wasPlaying.active) {
				wasPlaying.update();
			}
		}
		
		public static function fadeOutMusic(duration:Number = 0.5):void {
			if (FlxG.music != null) {
				//FlxG.music.fadeOut(duration);
			}
		}
		
		public static function play(resource:Class, volume:Number = 1.0):void {
			if (Registry.sound == Registry.ON) {
				FlxG.play(resource, volume);
			}
		}
		
		public static function mute():void {
			FlxG.music.stop();
			Registry.music = Registry.OFF;
		}
		
		public static function unmute():void {
			FlxG.playMusic(playing, playingVolume);
			Registry.music = Registry.ON;
		}
		
		public static function muteSounds():void {
			Registry.sound = Registry.OFF;
		}
		
		public static function unmuteSounds():void {
			Registry.sound = Registry.ON;
		}
		
		public static function initialize():void {
			ArcSfxr.create("jump", "0,,0.1387,,0.3055,0.31,,0.1876,,,,,,0.0794,,,,,1,,,,,0.5");
			ArcSfxr.create("doublejump", "0,,0.1387,,0.3055,0.36,,0.1876,,,,,,0.0794,,,,,1,,,,,0.5");
			ArcSfxr.create("save", "0,,0.1636,,0.3878,0.429,,0.4477,,,,,,0.5477,,0.4126,,,1,,,,,0.5");
			ArcSfxr.create("cast", "0,,0.2248,,0.17,0.36,,0.2913,,,,,,0.3012,,,,,0.8936,,,,,0.4");
			ArcSfxr.create("blip", "0,,0.0119,0.14,0.24,0.35,,,,,,,,,,,,,1,,,,,0.5");
			ArcSfxr.create("hitenemy", "3,,0.0987,,0.2687,0.6365,,-0.6477,,,,,,,,,,,1,,,0.1477,,0.6");
			ArcSfxr.create("killenemy", "3,,0.0987,,0.5,0.83,,-0.6477,,,,,,,,,,,1,,,0.1477,,0.7");
			ArcSfxr.create("thud", "1,,0.0174,,0.1625,0.7808,,-0.6455,,,,,,,,,,,1,,,0.1341,,0.5");
			ArcSfxr.create("playerdie", "3,,0.161,0.4487,0.52,0.18,,,,,,,,,,0.3884,0.2812,-0.2155,1,,,,,0.6");
			ArcSfxr.create("chargestart", "1,,0.2543,,0.5,0.2228,,0.2209,,,,,,,,,,,1,,,,,0.35");
			//ArcSfxr.create("chargecomplete", "0,,0.198,,0.16,0.62,,0.2248,,,,,,0.5726,,,,,1,,,,,0.4");
			ArcSfxr.create("pickup", "0,,0.3438,,0.3579,0.4782,,0.3072,,,,,,0.0113,,0.4028,,,1,,,,,0.5");
			
		}
	}
}
