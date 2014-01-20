//par4:Main
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class MusicControls extends MovieClip {
		//constants
		private const minVolume:Number = 0.1;//minimum stored volume
		private const sliderX:int = 120;
		private const sliderY:int = 0;
		private const soundButtonX:int = 0;
		private const soundButtonY:int = 0;
		//constructors
		private var px:uint;
		private var py:uint;
		
		private var musicVolume:Number=1;
		private var storedVolume:Number=1;
		
		private var volumeSlider:VolumeSlider;
		private var soundButton:SoundButton;
		
		private var par4:MovieClip;
		public function MusicControls(px:uint,py:uint,sliderVolume:Number):void {
			this.px = px;
			this.py = py;
			musicVolume = sliderVolume;
			storedVolume = sliderVolume;
			x = px;
			y = py;
			addComponents();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par4 = MovieClip(parent.parent.parent.parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//adds the components to the music controls
		private function addComponents():void {
			volumeSlider = new VolumeSlider(sliderX,sliderY);
			volumeSlider.updateSlider(musicVolume);
			addChild(volumeSlider);
			soundButton = new SoundButton(soundButtonX,soundButtonY);
			addChild(soundButton);
		}
		
		//toggles mute
		public function toggleMute():void {
			if(musicVolume==0) {
				musicVolume = storedVolume;
			} else {
				storedVolume = Math.max(musicVolume,minVolume);//Math.max(musicVolume,minVolume);
				musicVolume = 0;
			}
			volumeSlider.updateSlider(musicVolume);
			updateVolume(musicVolume);
		}
		
		//updates volume
		public function updateVolume(vol:Number):void {
			musicVolume = vol;
			par4.getMusicPlayer().updateVolume(musicVolume);
		}
	}
}