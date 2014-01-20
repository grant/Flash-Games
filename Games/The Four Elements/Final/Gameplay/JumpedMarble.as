package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class JumpedMarble extends MovieClip {
		//constants
		private const removedPanelX:uint = 670;//top left x position of the first removed marble
		private const removedPanelY:uint = 30;//top left y position of the first removed marble
		private const marbleColumnWidth:uint = 5;//number of marbles per row
		private const marbleSpacing:uint = 25;//space between each marble
		private const REMOVED_SIZE:uint = 20;//size of a marble that is on the remove panel
		
		private const moveEase:Number = 0.08;
		private const sizeEase:Number = 0.05;
		
		//constructors
		private var boardX:uint;//array x position on the board
		private var boardY:uint;//array y position on the board
		private var numRemovedMarble:uint;//the nth removed marble
		private var SIZE:uint;//size of a marble on the board
		private var SPACING:uint;//spacing between board marbles
		private var offx:uint;//board offx
		private var offy:uint;//board offy
		
		//variables
		private var removed:Boolean = true;//in the removed or not removed position
		private var desx:int;
		private var desy:int;
		private var desBoardX:uint;
		private var desBoardY:uint;
		private var desSize:int;
		
		private var par:MovieClip;
		private var par2:MovieClip;
		public function JumpedMarble(boardX:uint,boardY:uint,numRemovedMarble:uint,size:uint,spacing:uint,offx:uint,offy:uint):void {
			this.boardX = boardX;
			this.boardY = boardY;
			this.numRemovedMarble = numRemovedMarble;
			this.SIZE = size;
			this.SPACING = spacing;
			this.offx = offx;
			this.offy = offy;
			
			x = offx + (boardX*SPACING);
			y = offy + (boardY*SPACING);
			width = SIZE;
			height = SIZE;
			
			desx = removedPanelX + (marbleSpacing*(numRemovedMarble%marbleColumnWidth));
			desy = removedPanelY + (marbleSpacing*(Math.floor(numRemovedMarble/marbleColumnWidth)));
			desSize = REMOVED_SIZE;
			
			mouseEnabled = false;
			stop();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			par2 = MovieClip(parent.parent);
			addEventListener(Event.ENTER_FRAME,moveMarble);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//moves the marble
		private function moveMarble(e:Event):void {
			if(!removed) {
				if(Math.abs(desx-x)<1&&Math.abs(desy-y)<1) {
					remove();
				}
			}
			x += (desx-x)*moveEase;
			y += (desy-y)*moveEase;
			width += (desSize-width)*sizeEase;
			height += (desSize-height)*sizeEase;
		}
		
		//changes the destination of the jumped marble
		public function place(boardx:uint,boardy:uint):void {
			desBoardX = boardx;
			desBoardY = boardy;
			removed = false;
			desx = offx + (boardx*SPACING);
			desy = offy + (boardy*SPACING);
			desSize = SIZE;
		}
		
		//removes the marble
		public function remove():void {
			par2.addMarbleNum();
			par2.setHasMarble(desBoardX,desBoardY);
			par2.setHasMarble(desBoardX,desBoardY);
			removeEventListener(Event.ENTER_FRAME,moveMarble);
			par.removeChild(this);
		}
	}
}