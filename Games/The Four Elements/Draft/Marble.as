package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Marble extends MovieClip {
		public var frame:uint;
		public var boardX:uint;
		public var boardY:uint;
		public var w:uint;
		public var h:uint;

		public var par:MovieClip;
		public function Marble(a:uint,b:uint,xPos:uint,yPos:uint,wid:uint,hei:uint) {
			boardX=a;
			boardY=b;
			x=xPos;
			y=yPos;
			w=wid;
			h=hei;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par=MovieClip(parent);
			frame=par.startBoard[boardX][boardY]+1;
			gotoAndStop(frame);
			width=w;
			height=h;

			addEventListener(MouseEvent.MOUSE_DOWN,select);
			addEventListener(MouseEvent.MOUSE_UP,deselect);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function select(e:MouseEvent):void {
			if (frame==3) {//marble
				if (! par.holdingMarble) {//hold marble
					par.lastMarbleX=x;
					par.lastMarbleY=y;
					par.lastBoardX=boardX;
					par.lastBoardY=boardY;
					par.selectMarble(true,x,y);
					frame=2;
					par.board[boardX][boardY]=1;
					changeFrame(frame);
				} else {//return marble
					returnMarble(false);
				}
			}
		}
		private function deselect(e:MouseEvent):void {
			if (frame==2) {//empty
				if (par.holdingMarble) {//put down mrable
					if ((Math.abs(boardX-par.lastBoardX)==2&&Math.abs(boardY-par.lastBoardY)==0)) {
						if (par.board[(boardX+par.lastBoardX)/2][boardY]==2) {
							changeMarble();
							removeMarble((boardX+par.lastBoardX)/2,boardY);
						} else {
							returnMarble(true);
						}
					} else if (Math.abs(boardY-par.lastBoardY)==2&&Math.abs(boardX-par.lastBoardX)==0) {
						if (par.board[boardX][(boardY+par.lastBoardY)/2]==2) {
							changeMarble();
							removeMarble(boardX,(boardY+par.lastBoardY)/2);
						} else {
							returnMarble(true);
						}
					} else if (boardY==par.lastBoardY&&boardX==par.lastBoardX) {
						changeMarble();
					} else {
						returnMarble(true);
					}
				}
			} else if(frame==3){
				if (par.holdingMarble) {
					returnMarble(true);
				}
			}
		}
		private function changeMarble():void {
			par.selectMarble(false);
			frame=3;
			par.board[boardX][boardY]=2;
			par.holder[boardY][boardX].changeFrame(3);
			changeFrame(frame);
		}
		private function removeMarble(xPos:uint,yPos:uint):void {
			par.board[xPos][yPos]=1;
			par.holder[yPos][xPos].changeFrame(2);
			par.addFinish(par.holder[yPos][xPos].x,par.holder[yPos][xPos].y);
		}
		public function returnMarble(flashRed:Boolean):void {
			par.addReturn(flashRed,par.select.x,par.select.y);
			par.selectMarble(false);
		}
		public function changeFrame(f:uint):void {
			frame=f;
			gotoAndStop(f);
		}
	}
}