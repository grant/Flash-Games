package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class BlackPause extends MovieClip {
		public var par:MovieClip;
		public function BlackPause() {
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		private function onClick(e:MouseEvent):void {
			removeEventListener(MouseEvent.CLICK,onClick);
			par.pausing=false;
			par.removeChild(this);
		}
	}
}