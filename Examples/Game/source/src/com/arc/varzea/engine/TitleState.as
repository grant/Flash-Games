package com.arc.varzea.engine {
	import com.arc.flixel.ArcButton;
	import com.arc.flixel.ArcSprite;
	import com.arc.flixel.DataSerializer;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.resource.Sound;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.SoundSystem;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;

	public class TitleState extends GameState {
		private var name:ArcSprite;
		private var fadeIn:Boolean = true;
		
		private var buttonNew:ArcButton;
		private var buttonContinue:ArcButton;
		
		private var buttonSoundOn:ArcButton;
		private var buttonSoundOff:ArcButton;
		private var buttonMusicOn:ArcButton;
		private var buttonMusicOff:ArcButton;
		
		private var clicked:Boolean = false;
		
		public function TitleState() {	
			music();
			this.add(new ArcSprite(0, 0, Resource.TITLE));
			this.add(name = new ArcSprite(0, 0, Resource.NAME));
			name.alpha = 0;
			
			this.add(buttonNew = new ArcButton(99, 144, 64, 16, Resource.BUTTON_NEW_GAME).selectable(false).callback(function():void {
				if (clicked) { return; }
				clicked = true;
				
				FlxG.camera.fade(0xff000000, 0.5, function():void {
					DataSerializer.reset();
					Registry.engine.push(new WorldState);
					FlxG.camera.stopFX();
					clicked = false;
				});
			}));
			
			this.add(buttonContinue = new ArcButton(196, 144, 64, 16, Resource.BUTTON_CONTINUE).selectable(false).callback(function():void {
				if (clicked) { return; }
				clicked = true;
				
				FlxG.camera.fade(0xff000000, 0.5, function():void {
					DataSerializer.load();
					Registry.engine.push(new WorldState);
					FlxG.camera.stopFX();
					clicked = false;
				});
			}));
			
			this.add(buttonMusicOn = new ArcButton(52, 208, 64, 16, Resource.BUTTON_MUSIC_ON).selectable(false).callback(function():void {
				Registry.music = Registry.OFF;
				SoundSystem.mute();
				buttonMusicOn.visible = false;
				buttonMusicOff.visible = true;
				FlxG.mouse.reset();
				DataSerializer.save();
			}));
			
			this.add(buttonMusicOff = new ArcButton(52, 208, 64, 16, Resource.BUTTON_MUSIC_OFF).selectable(false).callback(function():void {
				Registry.music = Registry.ON;
				SoundSystem.unmute();
				buttonMusicOn.visible = true;
				buttonMusicOff.visible = false;
				FlxG.mouse.reset();
				DataSerializer.save();
			}));
			
			if (Registry.music == Registry.ON) {
				buttonMusicOff.visible = false;
			} else {
				buttonMusicOn.visible = false;
				Registry.music = Registry.OFF;
			}
			
			this.add(buttonSoundOn = new ArcButton(244, 208, 64, 16, Resource.BUTTON_SOUND_ON).selectable(false).callback(function():void {
				Registry.sound = Registry.OFF;
				SoundSystem.muteSounds();
				buttonSoundOn.visible = false;
				buttonSoundOff.visible = true;
				FlxG.mouse.reset();
				DataSerializer.save();
			}));
			
			this.add(buttonSoundOff = new ArcButton(244, 208, 64, 16, Resource.BUTTON_SOUND_OFF).selectable(false).callback(function():void {
				Registry.sound = Registry.ON;
				SoundSystem.unmuteSounds();
				buttonSoundOn.visible = true;
				buttonSoundOff.visible = false;
				FlxG.mouse.reset();
				DataSerializer.save();
			}));
			
			if (Registry.sound == Registry.ON) {
				buttonSoundOff.visible = false;
			} else {
				buttonSoundOn.visible = false;
				Registry.sound = Registry.OFF;
			}
			
			trace(Registry.music, Registry.sound);
			
			setAll("scrollFactor", new FlxPoint(0, 0), true);
		}
		
		public function music():void {
			SoundSystem.music(Sound.title, 1.0);
		}
		
		override public function update():void {			
			if (fadeIn) {
				name.alpha += FlxG.elapsed / 2;
				if (name.alpha >= 1) {
					fadeIn = false;
				}
			} else {
				name.alpha -= FlxG.elapsed / 2;
				if (name.alpha <= 0.3) {
					fadeIn = true;
				}
			}
			
			super.update();
		}
	}
}
