package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Nav extends MovieClip {
		private const ease:Number = .1;
		private var desw:uint = 350;//260
		private var desh:uint = 370;//300
		public function Nav(w:uint,h:uint):void {
			x = 200;
			y = 200;
			width = w;
			height = h;
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			width += (desw-width)*ease;
			height += (desh-height)*ease;
		}
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
			parent.removeChild(this);
		}
	}
}