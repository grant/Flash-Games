//par:MovieClip
//par2:Page
//par3:Main
//Layers organization (lowest to upper):
//-Board
//-Restart Button
//-Removed Marbles
//-Selected Marbles
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Game extends MovieClip {
		//game constants
		//board
		private const boardX:uint = 200;
		private const boardY:uint = 100;
		private const boardSpacing:uint = 50;
		private const marbleSize:uint = 45;
		//restart button
		private const restartX:uint = 570;
		private const restartY:uint = 600;
		//music controls
		private const musicControlsX:uint = 30;
		private const musicControlsY:uint = 570;
		//selection wheel
		private const selectionWheelX:uint = 400;
		private const selectionWheelY:uint = 0;
		
		//game vars
		private var mapName:String;//current map name
		private var elementId:uint;//the element id to set the frame of the marbles (1,2,3,4)
		private var numRemovedMarbles:uint = 0;//number of removed marbles
		private var marblesLeft:uint;
		private var resetting:Boolean = false;
		private var levelsUnlocked:uint;
		
		//game objects
		private var map:Map;//map object
		private var board:Board;//board and marbles
		private var restartButton:RestartButton;//restart button
		private var musicControls:MusicControls;//music controls
		private var selectionWheel:SelectionWheel;//selection wheel
		
		//arrays and layers
		private var removedMarbles:Array;//array of all removed marbles
		private var movedRemovedMarbles:Array = new Array();//array of moved marbles
		private var removedMarblesLayer:MovieClip;//removed marble layer
		private var selectedMarble:SelectedMarble;//selected marble
		private var selectedMarblesLayer:MovieClip;//selected marble layer
		
		private var par:MovieClip;
		private var par2:MovieClip;
		private var par3:MovieClip;
		public function Game(mapName:String,levelsUnlocked:uint):void {
			this.mapName = mapName;
			this.levelsUnlocked = levelsUnlocked;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			par2 = MovieClip(parent.parent);
			par3 = MovieClip(parent.parent.parent);
			setElementId();
			setMaps();
			setBoard();
			setRestartButton();
			setMusicControls();
			setRemovedMarbles();
			setSelectedMarbles();
			setSelectionWheel();
			updateScore()
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//sets the element id up
		private function setElementId():void {
			switch(mapName) {
				case "earth":
					elementId = 1;
					break;
				case "water":
					elementId = 2;
					break;
				case "air":
					elementId = 3;
					break;
				case "fire":
					elementId = 4;
					break;
			}
		}
		
		//sets the maps up
		private function setMaps():void {
			map = new Map();
			addChild(map);
			map.setMap(mapName);
			marblesLeft = map.getMarbleNum();
		}
		
		//sets up the removed marbles layer
		private function setRemovedMarbles():void {
			removedMarbles = new Array();
			removedMarblesLayer = new MovieClip();
			addChild(removedMarblesLayer);
		}
		
		//sets up the selected marbles layer
		private function setSelectedMarbles():void {
			selectedMarblesLayer = new MovieClip();
			addChild(selectedMarblesLayer);
		}
		
		//sets up the selection whel
		private function setSelectionWheel():void {
			selectionWheel = new SelectionWheel(elementId,selectionWheelX,selectionWheelY);
			selectionWheel.updateLevelsUnlocked(levelsUnlocked);
			addChild(selectionWheel);
		}
		
		//sets up the board
		private function setBoard():void {
			board = new Board(elementId);
			board.setPosition(boardX,boardY);
			board.setSpacing(boardSpacing);
			board.setWidHei(marbleSize);
			board.setMap(map);
			board.createBackground();
			
			board.addMarbles();
			addChild(board);
		}
		
		//sets up the restart button
		private function setRestartButton():void {
			restartButton = new RestartButton(restartX,restartY);
			addChild(restartButton);
		}
		
		//sets up the music controls
		private function setMusicControls():void {
			var vol:Number = 1;
			if(par3!=null) {
				vol = par3.getMusicPlayer().getMusicVolume();
			}
			musicControls = new MusicControls(musicControlsX,musicControlsY,vol);
			addChild(musicControls);
		}
		
		//adds a selected marble
		public function addSelectedMarble(px:uint,py:uint):void {
			selectedMarble = new SelectedMarble(elementId,px,py,marbleSize,boardSpacing,boardX,boardY);
			selectedMarblesLayer.addChild(selectedMarble);
		}
		
		//checks if there is already a selected marble
		public function hasSelected():Boolean {
			return selectedMarblesLayer.numChildren==1;
		}
		
		//add jumped marble
		public function addJumpedMarble(px:uint,py:uint):void {
			removedMarbles.push(new JumpedMarble(elementId,px,py,numRemovedMarbles,marbleSize,boardSpacing,boardX,boardY));
			removedMarblesLayer.addChild(removedMarbles[removedMarbles.length-1]);
			numRemovedMarbles++;
			marblesLeft = map.getMarbleNum();
			updateScore();
		}
		
		//gets the board
		public function getBoard():Board {
			return board;
		}
		
		//changes a marble to visible
		public function removeStaticMarble(px:uint,py:uint):void {
			board.removeMarble(px,py);
		}
		
		//resets the board
		public function resetBoard():void {
			if(numRemovedMarbles!=0&&!resetting) {//board has been played on and needs to be restarted, not already restarted yet
				par3.getScore().addRestartScore();//add a restart to the scores
				
				resetting = true;
				board.disableAll();
				
				//move removed marbles back
				var currentMap:Array = board.getMap().getMap();
				var originalMap:Array = board.getMap().getOriginalMap();
				
				//list of places that need marbles//
				var marbleNeeded:Array = new Array();
				for(var a:uint = 0;a<currentMap.length;a++) {
					for(var b:uint = 0;b<currentMap[0].length;b++) {
						if(currentMap[a][b]!=originalMap[a][b]) {
							marbleNeeded.push(new Array(b,a));
						}
					}
				}
				
				//list of places where there are marbles and they should be moved
				var boardChanges:Array = new Array();//places where marbles on the board need to be changed, do these first
				for(var i:uint = 0;i<currentMap.length;i++) {
					for(var j:uint = 0;j<currentMap[0].length;j++) {
						if(currentMap[i][j]==2&&originalMap[i][j]==1) {//if there is a marble in a place where there shouldn't be a marble
							boardChanges.push(new Array(j,i));//add this position to marbles that need to change places on the board
						}
					}
				}
				
				//move all current marble places that shouldn't be there to places where it is acceptable
				var boardChangesIndex:uint = 0;
				var removedMarblesIndex:uint = 0;
				for(var k:uint = 0;k<currentMap.length;k++) {
					for(var l:uint = 0;l<currentMap[0].length;l++) {
						if(currentMap[k][l]==1&&originalMap[k][l]==2) {//if there no marble in a place where there should be a marble
							//place a marble already on the board to that place
							if(boardChangesIndex<boardChanges.length) {
								numRemovedMarbles++;
								board.setHasMarble(boardChanges[boardChangesIndex][0],boardChanges[boardChangesIndex][1],false);
								movedRemovedMarbles.push(new JumpedMarble(elementId,boardChanges[boardChangesIndex][0],boardChanges[boardChangesIndex][1],0,marbleSize,boardSpacing,boardX,boardY));
								movedRemovedMarbles[movedRemovedMarbles.length-1].place(l,k);
								removedMarblesLayer.addChild(movedRemovedMarbles[movedRemovedMarbles.length-1]);
								boardChangesIndex++;
							} else {//move a marble from the removed marbles panel
								removedMarbles[removedMarblesIndex].place(l,k);
								removedMarblesIndex++;
							}
						}
					}
				}
				
				map.resetMap();
				marblesLeft = map.getMarbleNum();
				updateScore();
				addEventListener(Event.ENTER_FRAME,pendRestartedBoard);
			}
		}
		
		//checks to enable the board by checking the removed marbles
		private function pendRestartedBoard(e:Event):void {
			if(numRemovedMarbles == 0) {
				resetting = false;
				marblesLeft = 0;
				movedRemovedMarbles = new Array();//clear the removed marbles list
				removedMarbles = new Array();//clear the removed marbles list
				board.enableAll();
			}
		}
		
		//reduces the number of removed marbles (called when jumpedMarbles are removed)
		public function addMarbleNum():void {
			numRemovedMarbles--;
		}
		
		//sets back a marble to the has marble state
		public function setHasMarble(px:uint,py:uint):void {
			board.setHasMarble(px,py,true);
		}
		
		//removes the whole game and all of it's components
		public function remove():void {
			par.removeChild(this);
		}
		
		//updates the current score
		private function updateScore():void {
			par2.getScore().addScore(board.getMap().getMarbleNum(),mapName);
		}
		
		//gets the selection wheel
		public function getSelectionWheel():SelectionWheel {
			return selectionWheel;
		}
		
		//switches levels
		public function changeLevel(levelName:String):void {
			if(levelName!=mapName) {
				//switch levels
				//change song/ease out volume
				//change page
				//set selection wheel
				//play music
				par3.getMusicPlayer().easeOutMusic();//eases out music
				par2.setNextPage(levelName+" page");
				par2.gotoNextPage();
			}
		}
		
		//gets the element id
		public function getElementId():uint {
			return elementId;
		}
		
		//gets the page
		public function getPage():MovieClip {
			return par2;
		}
		
		//gets the map name
		public function getMapName():String {
			return mapName;
		}
	}
}