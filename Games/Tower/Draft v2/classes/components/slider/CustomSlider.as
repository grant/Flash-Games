/**
 * Slider bar for the music volume
 **/
package components.slider {
	//foreign classes
	import components.slider.Handle;
	//flash classes
	import flash.display.MovieClip;
	import flash.events.Event;
	public class CustomSlider extends MovieClip {
		//MCs
		private var handle:Handle;
		private var par:MovieClip;
		public function CustomSlider(px:int,py:int):void {
			x = px;
			y = py;
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			addHandle();
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		/**
		 * Adds the handle to the slider
		 **/
		private function addHandle():void {
			handle = new Handle(-5,-5,135,50);
			addChild(handle);
		}
	}
}