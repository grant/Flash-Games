package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Board extends MovieClip {		
		//map
		private var map:Map;
		
		//board
		private var px:int=0;//x of the board
		private var py:int=0;//y of the board
		private var SPACING:uint;//pixels between marbles
		private var SIZE:uint;//size of marbles
		private var bgGrid:Array;//tile background array
		private var bg:MovieClip;//background layer
		
		//marbles
		private var marbles:Array;//static marble objects
		private var marbleLayer:MovieClip;//marble layer
		public function Board():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//sets the board up based on the map
		public function setMap(map:Map):void {
			this.map = map;
		}
		
		//sets the top left position of the board
		public function setPosition(px:int,py:int):void {
			this.px = px;
			this.py = py;
		}
		
		//sets the spacing between the marbles
		public function setSpacing(spacing:uint):void {
			this.SPACING = spacing;
		}
		//sets the size of the marbles
		public function setWidHei(size:uint):void {
			this.SIZE = size;
		}
		
		//creates and displays the background
		public function createBackground():void {
			bg = new MovieClip();
			bg.x = px;
			bg.y = py;
			
			var boardmap:Array = map.getMap();
			bgGrid = new Array();
			for(var i:uint = 0;i<boardmap.length;i++) {
				bgGrid[i] = new Array();
				for(var j:uint = 0;j<boardmap[0].length;j++) {
					if(map.validPosition(j,i)) {
						bgGrid[i][j] = new EmptySpace(j*SPACING,i*SPACING);
						bgGrid[i][j].setWidHei(SIZE);
						bg.addChild(bgGrid[i][j]);
					}
				}
			}
			
			addChild(bg);
		}
		
		//removes the background
		public function removeBackground():void {
			//removes all background tiles
			var boardmap:Array = map.getMap();
			for(var i:uint = 0;i<boardmap.length;i++) {
				for(var j:uint = 0;j<boardmap[0].length;j++) {
					if(map.validPosition(j,i)) {
						bg.removeChild(bgGrid[i][j]);
					}
				}
			}

			removeChild(bg);
		}
		
		//changes the map and updates the board
		public function changeMap(map:Map):void {
			this.map = map;
			
			var boardmap:Array = map.getMap();
			for(var i:uint = 0;i<boardmap.length;i++) {
				for(var j:uint = 0;j<boardmap[0].length;j++) {
					if(bgGrid[i][j]==null&&map.validPosition(j,i)) {
						bgGrid[i][j] = new EmptySpace(j*SPACING,i*SPACING);
						bgGrid[i][j].setWidHei(SIZE);
						bg.addChild(bgGrid[i][j]);
					} else if(bgGrid[i][j]!=null&&!map.validPosition(j,i)) {
						bg.removeChild(bgGrid[i][j]);
					}
				}
			}
		}
		
		//gets the map object
		public function getMap():Map {
			return map;
		}
		
		//gets the array position of the tile (might or might not exist)
		public function getPosition(mousex:int,mousey:int):Array {
			var coordinates:Array = new Array();
			mousex -= px;
			mousey -= py;
			mousex += SPACING*0.5;//becuase xy reference is in the center of the marble
			mousey += SPACING*0.5;//becuase xy reference is in the center of the marble
			mousex = Math.floor(mousex/SPACING);
			mousey = Math.floor(mousey/SPACING);
			coordinates[0] = mousex;
			coordinates[1] = mousey;
			return coordinates;
		}
		
		//add marbles to the board
		public function addMarbles():void {
			marbles = new Array();
			marbleLayer = new MovieClip();
			
			var boardMap:Array = map.getMap();
			for(var i:uint = 0;i<boardMap.length;i++) {
				for(var j:uint = 0;j<boardMap[0].length;j++) {
					if(boardMap[i][j]==2||boardMap[i][j]==1) {
						marbles.push(new StaticMarble(j,i,SIZE,SPACING,px,py));
						if(boardMap[i][j]==2) {
							marbles[marbles.length-1].hasMarble(true);
						} else {
							marbles[marbles.length-1].hasMarble(false);
						}
						marbleLayer.addChild(marbles[marbles.length-1]);
					}
				}
			}
			
			addChild(marbleLayer);
		}
		
		//removes marbles from the board
		public function removeMarbles():void {
			//removes all marbles
			for(var i:uint = 0;i<marbles.length;i++) {
				marbleLayer.removeChild(marbles[i]);
			}
			
			removeChild(marbleLayer);
		}
		
		//updates all the marbles
		public function updateMarbles():void {
			for(var i:uint = 0;i<marbles.length;i++) {
				var position:Array = marbles[i].getPosition();
				marbles[i].hasMarble(map.getPosition(position[0],position[1])==2);
			}
		}
		
		//makes a marble invisible
		public function removeMarble(px:uint,py:uint):void {
			for(var i:uint = 0;i<marbles.length;i++) {
				var position:Array = marbles[i].getPosition();
				if(position[0] == px && position[1] == py) {
					marbles[i].hasMarble(false);
				}
			}
		}
		
		//disables all marbles
		public function disableAll():void {
			for(var i:uint = 0;i<marbles.length;i++) {
				marbles[i].disable(true);
			}
		}
		
		//enables all marbles
		public function enableAll():void {
			for(var i:uint = 0;i<marbles.length;i++) {
				marbles[i].disable(false);
			}
		}
		
		//set if a marble hasMarble
		public function setHasMarble(boardX:uint,boardY:uint,hasMarble:Boolean):void {
			var done:Boolean = false;
			var index:uint = 0;
			while(!done) {
				var position:Array = marbles[index].getPosition();
				if(boardX==position[0]&&boardY==position[1]) {
					done = true;
					marbles[index].hasMarble(hasMarble);
				}
				index++;
			}
		}
	}
}