//Ideas:
/*
Campaign: 10 lvls 2x5
Undo Button (save board array)
HighScore
Yellow Empty for finish 
Cookie
Share maps (must complete to submit
Awards
*/
//Organization
/*
Menu Screen: Play, Level Editor, Music
Play: 10 levels, Back, music (levels show either bronze, silver, gold, or blank 10 pointed star, this is based on # of marbles left)
Level: Restart, Menu, Music
Level editor: 
*/
package {
	import flash.display.MovieClip;
	public class Game extends MovieClip {
		
		//Game
		public var holdingMarble:Boolean=false;
		public var bg:Bg = new Bg();
		public var ease:Number=.5;
		//Marble
		public var xOffset:int = 50;
		public var yOffset:int = 50;
		public var wid:uint = 50;
		public var hei:uint = 50;
		public var spacing:uint = 1;
		//Arrays
		public var startBoard:Array;
		public var holder:Array = new Array();
		//
		public function Game() {
			setBg();
			setMap();
			setBoard();
			setQuality();
			setRestart();
		}
		private function setBg():void {
			addChild(bg);
		}
		private function setMap():void {
			startBoard = new Array();
			startBoard[0]=[0,0,2,2,2,0,0];
			startBoard[1]=[0,0,2,2,2,0,0];
			startBoard[2]=[2,2,2,2,2,2,2];
			startBoard[3]=[2,2,2,1,2,2,2];
			startBoard[4]=[2,2,2,2,2,2,2];
			startBoard[5]=[0,0,2,2,2,0,0];
			startBoard[6]=[0,0,2,2,2,0,0];
		}
		public var board:Array = new Array();
		public function setBoard():void {
			for(var a:uint = 0;a<startBoard[0].length;a++){//width
				holder[a] = new Array();
				board[a] = new Array();
				for(var b:uint = 0;b<startBoard.length;b++){//height
					holder[a][b] = new Marble(b,a,xOffset+(a*(spacing+wid)),yOffset+(b*(spacing+hei)),wid,hei);
					board[a][b] = startBoard[a][b];
					addChild(holder[a][b]);
				}
			}
		}
		public var qualBTN:BTN = new BTN("quality",500,350,30,30);
		private function setQuality():void {
			addChild(qualBTN);
		}
		public var restartBTN:BTN = new BTN("restart",500,300,30,30);
		private function setRestart():void {
			addChild(restartBTN);
		}
		public var lastMarbleX:uint;
		public var lastMarbleY:uint;
		public var lastBoardX:uint;
		public var lastBoardY:uint;
		public var select:Selected;
		public function selectMarble(yn:Boolean=true,xPos:int=0,yPos:int=0):void {
			if(yn){
				if(!holdingMarble){
					holdingMarble=true;
					select = new Selected(stage.mouseX-xPos,stage.mouseY-yPos,wid,hei);
					addChild(select);
				}
			} else {
				if(holdingMarble){
					holdingMarble=false;
					select.remove();
				}
			}
		}
		public function addReturn(flashRed:Boolean,xPos:uint,yPos:uint):void {
			var returnMarble:Return = new Return(flashRed,xPos,yPos,wid,hei,lastMarbleX,lastMarbleY,lastBoardY,lastBoardX);
			addChild(returnMarble);
		}
		public var finishedMarbles:uint = 0;
		private var numberPerRow:uint = 8;
		private var finishXOff:uint = 390;
		private var finishYOff:uint = 20;
		private var finishXSpacing:uint = 20;
		private var finishYSpacing:uint = 20;
		private var finishedArray:Array = new Array ();
		public function addFinish(xPos:uint,yPos:uint):void {
			finishedArray[finishedMarbles] = new Finish(xPos,yPos,wid,hei,wid/2,hei/2,finishXOff+(finishXSpacing*(finishedMarbles%numberPerRow)),finishYOff+(finishYSpacing*Math.floor(finishedMarbles/numberPerRow)));
			addChild(finishedArray[finishedMarbles]);
			finishedMarbles++;
		}
		public function resetMarbles():void {
			for(var i:uint=0;i<finishedMarbles;i++){
				finishedArray[i].remove();
			}
			finishedMarbles=0;
		}
	}
}