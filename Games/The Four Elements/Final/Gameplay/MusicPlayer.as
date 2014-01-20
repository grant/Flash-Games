package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	public class MusicPlayer extends MovieClip {
		private var s:Sound;
		private var musicVolume:Number = 1;
		
		private var musicChannel:SoundChannel;
		private var effectChannel:SoundChannel;
		public function MusicPlayer():void {
			//setChannel();
			playMusic("earth");
		}
		/*
		//sets the music channel
		private function setChannel():void {
			musicChannel = new SoundChannel();
			effectChannel = new SoundChannel();
		}
		*/
		
		//adjusts the volume
		private function adjustMusicVolume(vol:Number):void {
			var st:SoundTransform = new SoundTransform(vol);
			musicChannel.soundTransform = st;
		}
		
		//load and play music
		public function playMusic(musicName:String):void {
			s = new Sound(new URLRequest("../Music/" + musicName + ".mp3"));
			s.addEventListener(Event.COMPLETE,musicLoadComplete);
		}
		
		//music is loaded
		private function musicLoadComplete(e:Event):void {
			musicChannel = s.play();
			easeInMusic();
			musicChannel.addEventListener(Event.SOUND_COMPLETE, musicComplete);
		}
		
		//music is complete
		private function musicComplete(e:Event):void {
			musicChannel.removeEventListener(Event.SOUND_COMPLETE, musicComplete);
		}
		
		//eases the music volume from nothing to full
		private function easeInMusic():void {
			musicVolume = 0;
			addEventListener(Event.ENTER_FRAME,easeIn);
		}
		private function easeIn(e:Event):void {
			musicVolume += 0.01;
			adjustMusicVolume(musicVolume);
			if(musicVolume>=1) {
				musicVolume = 1;
				removeEventListener(Event.ENTER_FRAME,easeIn);
			}
		}
		
		//eases the music volume from full to nothing
		private function easeOutMusic():void {
			musicVolume = 1;
			addEventListener(Event.ENTER_FRAME,easeIn);
		}
		private function easeOut(e:Event):void {
			musicVolume -= 0.01;
			adjustMusicVolume(musicVolume);
			if(musicVolume<=0) {
				musicVolume = 0;
				removeEventListener(Event.ENTER_FRAME,easeIn);
			}
		}
	}
}