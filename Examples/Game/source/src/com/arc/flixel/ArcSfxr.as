package com.arc.flixel {
	import com.arc.varzea.util.Registry;
	public class ArcSfxr {
		private static var _sounds:Object = { };
		
		public static function create(name:String, settings:String):void {
			var sound:SfxrSynth = new SfxrSynth();
			sound.params.setSettingsString(settings);
			sound.cacheSound();
			_sounds[name] = sound;
		}
		
		public static function play(name:String):void {
			if (_sounds[name] == null || !Registry.soundEnabled()) {
				return;
			}
			(_sounds[name] as SfxrSynth).play();
		}
	}
}
