package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Bg extends MovieClip {
		private var par:MovieClip;
		public function Bg() {
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(MouseEvent.MOUSE_UP,onUp);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			stage.addEventListener(Event.MOUSE_LEAVE,onLeave);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onUp(e:MouseEvent):void {
			removeMarble();
		}
		private function onLeave(e:Event):void {
			removeMarble();
		}
		private function removeMarble():void {
			if(par.holdingMarble){
				par.addReturn(false,par.select.x,par.select.y);
				par.selectMarble(false);
			}
		}
		public function remove():void {
			removeEventListener(Event.MOUSE_LEAVE,onLeave);
			removeEventListener(MouseEvent.MOUSE_UP,onUp);
			MovieClip(parent).removeChild(this);
		}
	}
}