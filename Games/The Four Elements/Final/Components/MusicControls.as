package {
	import flash.display.MovieClip;
	public class MusicControls extends MovieClip {
		//constants
		private const minVolume:Number = 0.1;//minimum stored volume
		private const sliderX:int = 0;
		private const sliderY:int = -120;
		private const soundButtonX:int = 0;
		private const soundButtonY:int = 0;
		//constructors
		private var px:uint;
		private var py:uint;
		
		private var musicVolume:Number=1;
		private var storedVolume:Number=1;
		
		private var volumeSlider:VolumeSlider;
		private var soundButton:SoundButton;
		public function MusicControls(px:uint,py:uint):void {
			this.px = px;
			this.py = py;
			x = px;
			y = py;
			addComponents();
		}
		
		//adds the components to the music controls
		private function addComponents():void {
			volumeSlider = new VolumeSlider(sliderX,sliderY);
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
		}
		
		//updates volume
		public function updateVolume(vol:Number):void {
			musicVolume = vol;
			trace(vol);
		}
	}
}