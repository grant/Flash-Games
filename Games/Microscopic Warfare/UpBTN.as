package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class UpBTN extends MovieClip {
		public var f:uint;
		public var par:MovieClip;
		public function UpBTN(frame:uint,xPos:uint,yPos:uint) {
			f = frame;
			gotoAndStop(f);
			x = xPos;
			y = yPos;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			addEventListener(MouseEvent.CLICK,onClick);
			addEventListener(MouseEvent.ROLL_OUT,onOut);
			addEventListener(MouseEvent.ROLL_OVER,onIn);
		}
		public function onClick(e:MouseEvent):void {
			switch(f) {
				case 1:
					par.cell.acc+=.25;
					par.cell.maxXs+=.5;
					par.cell.maxYs+=.5;
					break;
				case 2:
					par.cell.desWidth+=3;
					par.cell.desHeight+=3;
					break;
				case 3:
					par.cell.cellIncrease*=.95;
					break;
			}
			par.removeAllUp();
			par.pausing=false;
		}
		public function onOut(e:MouseEvent):void {
			gotoAndStop(f);
		}
		public function onIn(e:MouseEvent):void {
			gotoAndStop(f+3);
		}
		public function remove():void {
			removeEventListener(MouseEvent.ROLL_OUT,onOut);
			removeEventListener(MouseEvent.ROLL_OVER,onIn);
			removeEventListener(MouseEvent.CLICK,onClick);
		}
	}
}