package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Finish extends MovieClip {
		private var xStart:uint;
		private var yStart:uint;
		private var xDes:uint;
		private var yDes:uint;
		private var wStart:uint;
		private var hStart:uint;
		private var wDes:uint;
		private var hDes:uint;
		private var ease:Number;
		private var par:MovieClip;
		public function Finish(xPos:uint,yPos:uint,wid:uint,hei:uint,widD:uint,heiD:uint,xD:uint,yD:uint) {
			xStart = xPos;
			yStart = yPos;
			x = xPos;
			y = yPos;
			wStart = wid;
			hStart = hei;
			width = wid;
			height = hei;
			wDes = widD;
			hDes = heiD;
			xDes = xD;
			yDes = yD;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			ease = par.ease/4;
			addEventListener(Event.ENTER_FRAME,forward);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function forward(e:Event):void {
			x += (xDes-x)*ease;
			y += (yDes-y)*ease;
			width += (wDes-width)*ease;
			height += (hDes-height)*ease;
		}
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,forward);
			par.removeChild(this);
		}
	}
}