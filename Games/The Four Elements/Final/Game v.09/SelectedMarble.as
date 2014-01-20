//par2:Game
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class SelectedMarble extends MovieClip {
		//constants
		private const moveEase:Number = .4;
		
		//constructors
		private var boardX:uint;//array x position on the board
		private var boardY:uint;//array y position on the board
		private var SIZE:uint;//size of a marble on the board
		private var SPACING:uint;//spacing between board marbles
		private var offx:uint;//board offx
		private var offy:uint;//board offy
		
		//variables
		private var elementId:uint//element id of the marble
		private var desx:uint;//destination x
		private var desy:uint;//destination y
		private var desBoardX:uint;//boardX destination
		private var desBoardY:uint;//boardY destination
		private var deselected:Boolean = false;//if let go of the mouse button or not
		private var returning:Boolean = true;//if returning to the original position or jumping
		
		private var playedSfx:Boolean = false;//if played the sound effect for the marble or not
		
		private var par:MovieClip;
		private var par2:MovieClip;
		public function SelectedMarble(elementId:uint,boardX:uint,boardY:uint,size:uint,spacing:uint,offx:uint,offy:uint):void {
			this.elementId = elementId;
			gotoAndStop(elementId);
			this.boardX = boardX;
			this.boardY = boardY;
			this.SIZE = size;
			this.SPACING = spacing;
			this.offx = offx;
			this.offy = offy;
			
			x = offx + (boardX*SPACING);
			y = offy + (boardY*SPACING);
			width = SIZE;
			height = SIZE;
			
			stop();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			par2 = MovieClip(parent.parent);
			addEventListener(Event.ENTER_FRAME,moveMarble);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseIsUp);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//moves the marble
		private function moveMarble(e:Event):void {
			if(!deselected) {//follow mouse
				desx = stage.mouseX;
				desy = stage.mouseY;
			}
			x += (desx-x)*moveEase;
			y += (desy-y)*moveEase;
			if(deselected) {
				if(Math.abs(desx-x)<20&&Math.abs(desy-y)<20&&!playedSfx&&!returning) {//play sound effect
					playedSfx = true;
					par2.getPage().getMain().getMusicPlayer().playSoundEffect();
				}
				if(Math.abs(desx-x)<1&&Math.abs(desy-y)<1) {//change marble state
					if(returning) {
						par2.getBoard().updateMarbles();
						remove();
					} else {//hopping
						par2.getBoard().updateMarbles();
						remove();
					}
				}
			}
		}
		
		//puts the marble either to the new position if valid or back to the original place
		private function mouseIsUp(e:MouseEvent):void {
			deselected = true;
			var position:Array = par2.getBoard().getPosition(stage.mouseX,stage.mouseY);
			if(par2.getBoard().getMap().canMove(boardX,boardY,position[0],position[1])) {
				desx = offx + (position[0]*SPACING);
				desy = offy + (position[1]*SPACING);
				desBoardX = position[0];
				desBoardY = position[1];
				returning = false;
				par2.removeStaticMarble((boardX+desBoardX)/2,(boardY+desBoardY)/2);
				par2.getBoard().getMap().hopMarble(boardX,boardY,desBoardX,desBoardY);
				par2.addJumpedMarble((boardX+desBoardX)/2,(boardY+desBoardY)/2);
			} else {
				desx = offx + (boardX*SPACING);
				desy = offy + (boardY*SPACING);
				returning = true;
			}
			setReturningState();//unhighlights afterd deselected
		}
		
		//removes the marble
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,moveMarble);
			stage.removeEventListener(MouseEvent.MOUSE_UP,mouseIsUp);
			par.removeChild(this);
		}
		
		//sets the returning state (not highlighted)
		private function setReturningState():void {
			if(currentFrame>=1&&currentFrame<=4) {
				gotoAndStop(currentFrame+4);
			}
		}
	}
}