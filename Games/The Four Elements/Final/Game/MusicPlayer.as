package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	public class MusicPlayer extends MovieClip {
		private const SFX_VOLUME:Number = 0.3;
		private const EASE_IN_SPEED:Number = 0.01;
		private const EASE_OUT_SPEED:Number = 0.03;
		
		private var s:Sound;//music sound
		private var sfx:Sound;//sound effect
		private var sfxGood:Boolean = false;//if the sfx has loaded yet
		private var controlledVolume:Number = 1;//changable
		private var musicVolume:Number = 1;//for eases
		private var rootURL:String;//the root URL for the swf
		
		private var musicChannel:SoundChannel;
		private var effectChannel:SoundChannel;
		public function MusicPlayer(rootURL:String):void {
			this.rootURL = rootURL;
			//loads the sound effect
			sfx = new Sound();
			sfx.addEventListener(Event.COMPLETE,sfxComplete);
			sfx.load(new URLRequest(getSourceURL()+"jump.mp3"));
		}

		//gets the root url
		private function getSourceURL():String {
  			return rootURL.substring(0, rootURL.lastIndexOf("/") + 1);
		}
		
		//adjusts the volume
		private function adjustMusicVolume(vol:Number):void {
			var st:SoundTransform = new SoundTransform(vol*controlledVolume);
			musicChannel.soundTransform = st;
			if(effectChannel!=null) {
				effectChannel.soundTransform = st;
			}
		}
		
		//loads music
		public function playMusic(musicName:String):void {
			s = new Sound();
			s.addEventListener(Event.COMPLETE,musicLoadComplete);
			s.load(new URLRequest(getSourceURL()+musicName + ".mp3"));
		}
		
		//stops the current music
		public function stopMusic():void {
			if(musicChannel!=null) {//if there is music playing
				musicChannel.stop();
			}
		}
		
		//music is loaded
		private function musicLoadComplete(e:Event):void {
			startPlaying();
			easeInMusic();
		}
		
		//starts playing the music
		private function startPlaying():void {
			musicChannel = s.play();
			adjustMusicVolume(1);
			musicChannel.addEventListener(Event.SOUND_COMPLETE, musicComplete);
		}
		
		//music is complete, loop music
		private function musicComplete(e:Event):void {
			if(musicChannel!=null) {
				musicChannel.removeEventListener(Event.SOUND_COMPLETE, musicComplete);
				startPlaying();
			}			
		}
		
		//eases the music volume from nothing to full
		public function easeInMusic():void {
			musicVolume = 0;
			addEventListener(Event.ENTER_FRAME,easeIn);
		}
		private function easeIn(e:Event):void {
			musicVolume += EASE_IN_SPEED;
			adjustMusicVolume(musicVolume);
			if(musicVolume>=1) {
				musicVolume = 1;
				removeEventListener(Event.ENTER_FRAME,easeIn);
			}
		}
		
		//eases the music volume from full to nothing
		public function easeOutMusic():void {
			musicVolume = 1;
			addEventListener(Event.ENTER_FRAME,easeOut);
		}
		private function easeOut(e:Event):void {
			musicVolume -= EASE_OUT_SPEED;
			adjustMusicVolume(musicVolume);
			if(musicVolume<=0) {
				musicVolume = 0;
				removeEventListener(Event.ENTER_FRAME,easeOut);
			}
		}
		
		//updates the volume
		public function updateVolume(vol:Number):void {
			controlledVolume = vol;
			adjustMusicVolume(1);
		}
		
		//gets the volume
		public function getMusicVolume():Number {
			return controlledVolume;
		}
		
		//sfx has loaded
		private function sfxComplete(e:Event):void {
			sfxGood = true;
		}
		
		//play sound effect
		public function playSoundEffect():void {
			if(sfxGood) {
				effectChannel = sfx.play();
				//adjust the volume to what the sfx volume should be
				var st:SoundTransform = new SoundTransform(musicVolume*controlledVolume*SFX_VOLUME);
				effectChannel.soundTransform = st;
			}
		}
	}
}