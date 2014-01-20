//par:MusicControls
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class VolumeSlider extends MovieClip {
		private var px:int;
		private var py:int;
		private var musicVolume:Number = 1;
		private var handle:VolumeSliderHandle;
		private var par:MovieClip;
		public function VolumeSlider(px:int,py:int):void {
			this.px = px;
			this.py = py;
			x = px;
			y = py;
			addHandle();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//adds a handle
		private function addHandle():void {
			handle = new VolumeSliderHandle(0,100);
			addChild(handle);
		}
		
		//updates the slider
		public function updateSlider(vol:Number):void {
			handle.setPosition(vol);
		}
		
		//updates the volume
		public function updateVolume(vol:Number):void {
			par.updateVolume(vol);
		}
	}
}