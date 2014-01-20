package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Return extends MovieClip {
		private var xDes:uint;
		private var yDes:uint;
		private var boardX:uint;
		private var boardY:uint;
		private const accuracy:Number = .5;
		private var par:MovieClip;
		public function Return(flashRed:Boolean,xPos:uint,yPos:uint,wid:uint,hei:uint,xD:uint,yD:uint,xBoard:uint,yBoard:uint) {
			x = xPos;
			y = yPos;
			width = wid;
			height = hei;
			xDes = xD;
			yDes = yD;
			boardX = xBoard;
			boardY = yBoard;
			this.mouseEnabled=false;
			if(flashRed){
				gotoAndStop(2);
			} else {
				gotoAndStop(1);
			}
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			addEventListener(Event.ENTER_FRAME,onLoop);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onLoop(e:Event):void {
			x += (xDes-x)*par.ease;
			y += (yDes-y)*par.ease;
			if(Math.abs(xDes-x)<accuracy&&Math.abs(yDes-y)<accuracy){
				par.holder[boardX][boardY].changeFrame(3);
				par.board[boardY][boardX] = 2;
				removeEventListener(Event.ENTER_FRAME,onLoop);
				par.removeChild(this);
			}
		}
	}
}