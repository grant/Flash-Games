package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Bar extends MovieClip {
		public function Bar(hei:uint) {
			x = 0;
			y = 400-hei;
			height = hei;
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			width = (MovieClip(parent.parent).cell.upgradeAmount/MovieClip(parent.parent).cell.maxAmount)*550;
		}
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
			MovieClip(parent).removeChild(this);
		}
	}
}