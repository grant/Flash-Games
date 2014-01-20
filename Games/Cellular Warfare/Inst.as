package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class Inst extends MovieClip {
		public function Inst():void {
			addEventListener(MouseEvent.CLICK,onClick);
		}
		private function onClick(e:MouseEvent):void {
			MovieClip(parent).pausing=false;
			removeEventListener(MouseEvent.CLICK,onClick);
			MovieClip(parent).removeChild(this);
		}
	}
}