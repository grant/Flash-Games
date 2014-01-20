//par:MusicControls
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class SoundButton extends MovieClip {
		private var px:int;
		private var py:int;
		private var par:MovieClip;
		public function SoundButton(px:int,py:int):void {
			this.px = px;
			this.py = py;
			x = px;
			y = py;
			buttonMode = true;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			addEventListener(MouseEvent.CLICK,onClick);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//on click
		private function onClick(e:MouseEvent):void {
			par.toggleMute();
		}
	}
}