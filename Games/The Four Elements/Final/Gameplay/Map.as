package {
	import flash.display.MovieClip;
	public class Map extends MovieClip {
		private var mapName:String;//currrent map name
		private var maps:Array;//array of all maps
		private var currentMap:Array;//current map
		public function Map():void {
			setMaps();
		}

		//sets up the maps
		private function setMaps():void {
			//Organization:
			//
			//maps->
			//maps->earth
			//maps->water
			//maps->air
			//maps->fire
			//
			//Legend:
			//
			//0 = not a tile
			//1 = empty tile
			//2 = marble tile
			//

			maps = new Array();

			//earth
			maps[0] = new Array();
			maps[0][0]=new Array(0,0,0,2,2,2,0,0,0);
			maps[0][1]=new Array(0,0,0,2,2,2,0,0,0);
			maps[0][2]=new Array(0,0,0,2,2,2,0,0,0);
			maps[0][3]=new Array(2,2,2,2,2,2,2,2,2);
			maps[0][4]=new Array(2,2,2,2,1,2,2,2,2);
			maps[0][5]=new Array(2,2,2,2,2,2,2,2,2);
			maps[0][6]=new Array(0,0,0,2,2,2,0,0,0);
			maps[0][7]=new Array(0,0,0,2,2,2,0,0,0);
			maps[0][8]=new Array(0,0,0,2,2,2,0,0,0);

			//water
			maps[1] = new Array();
			maps[1][0]=new Array(0,0,0,0,0,0,0,0,0);
			maps[1][1]=new Array(0,0,2,2,1,2,2,0,0);
			maps[1][2]=new Array(0,2,2,2,2,2,2,2,0);
			maps[1][3]=new Array(0,2,2,2,2,2,2,2,0);
			maps[1][4]=new Array(0,1,2,2,1,2,2,1,0);
			maps[1][5]=new Array(0,2,2,2,2,2,2,2,0);
			maps[1][6]=new Array(0,2,2,2,2,2,2,2,0);
			maps[1][7]=new Array(0,0,2,2,1,2,2,0,0);
			maps[1][8]=new Array(0,0,0,0,0,0,0,0,0);

			//air
			maps[2] = new Array();
			maps[2][0]=new Array(2,2,2,0,0,0,2,2,2);
			maps[2][1]=new Array(2,2,2,2,0,2,2,2,2);
			maps[2][2]=new Array(2,2,2,2,2,2,2,2,2);
			maps[2][3]=new Array(0,2,2,2,2,2,2,2,0);
			maps[2][4]=new Array(0,0,2,2,1,2,2,0,0);
			maps[2][5]=new Array(0,2,2,2,2,2,2,2,0);
			maps[2][6]=new Array(2,2,2,2,2,2,2,2,2);
			maps[2][7]=new Array(2,2,2,2,0,2,2,2,2);
			maps[2][8]=new Array(2,2,2,0,0,0,2,2,2);

			//fire
			maps[3] = new Array();
			maps[3][0]=new Array(0,0,2,2,2,2,2,0,0);
			maps[3][1]=new Array(0,2,2,2,2,2,2,2,0);
			maps[3][2]=new Array(2,2,2,2,2,2,2,2,2);
			maps[3][3]=new Array(2,2,2,2,2,2,2,2,2);
			maps[3][4]=new Array(2,2,2,2,1,2,2,2,2);
			maps[3][5]=new Array(2,2,2,2,2,2,2,2,2);
			maps[3][6]=new Array(2,2,2,2,2,2,2,2,2);
			maps[3][7]=new Array(0,2,2,2,2,2,2,2,0);
			maps[3][8]=new Array(0,0,2,2,2,2,2,0,0);
		}

		//sets currentMap as a copy of one of the maps
		public function setMap(mapName:String):void {
			this.mapName = mapName;
			switch (mapName) {
				case "earth" :
					currentMap=copyMap(maps[0]);
					break;
				case "water" :
					currentMap=copyMap(maps[1]);
					break;
				case "air" :
					currentMap=copyMap(maps[2]);
					break;
				case "fire" :
					currentMap=copyMap(maps[3]);
					break;
			}
		}

		//checks if the user can move a marble from position a to position b
		public function canMove(ax:uint,ay:uint,bx:uint,by:uint):Boolean {
			var can:Boolean=false;
			if (validPosition(ax,ay)&&validPosition(bx,by)) {//two positions on the map
				if (currentMap[ay][ax]==2) {//grabbing tile has marble
					if (currentMap[by][bx]==1) {//placing tile is an empty tile
						if (ay-by==0) {//same y position
							if (ax-bx==2) {//from right to left
								if (currentMap[ay][bx+1]==2) {
									can=true;
								}
							} else if (bx-ax==2) {//from left to right
								if (currentMap[ay][bx-1]==2) {
									can=true;
								}
							}
						} else if (ax-bx==0) {//same x position
							if (ay-by==2) {//below to above
								if (currentMap[by+1][ax]==2) {
									can=true;
								}
							} else if (by-ay==2) {//above to below
								if (currentMap[by-1][ax]==2) {
									can=true;
								}
							}
						}
					}
				}
			}
			return can;
		}
		
		//hops the marble from position a to position b on the map
		public function hopMarble(ax:uint,ay:uint,bx:uint,by:uint):void {
			currentMap[ay][ax] = 1;//marble removed from here
			currentMap[(ay+by)/2][(ax+bx)/2] = 1;//hopped marble
			currentMap[by][bx] = 2;//marble placed here
		}
		
		//if there is a move left
		public function moveLeft():Boolean {
			var moveIsLeft:Boolean = false;
			var i:uint = 0;
			while(!moveIsLeft&&i<currentMap.length) {
				var j:uint = 0;
				while(!moveIsLeft&&j<currentMap[0].length) {
					if(i>1) {//maybe can hop up
						if(canMove(i,j,i-2,j)) {
							moveIsLeft = true;
						}
					}
					if(i<currentMap.length-2) {//maybe can hop down
						if(canMove(i,j,i+2,j)) {
							moveIsLeft = true;
						}
					}
					if(j>1) {//maybe can hop left
						if(canMove(i,j,i,j-2)) {
							moveIsLeft = true;
						}
					}
					if(j<currentMap[0].length-2) {//maybe can hop right
						if(canMove(i,j,i,j+2)) {
							moveIsLeft = true;
						}
					}
					j++;
				}
				i++;
			}
			return moveIsLeft;
		}
		
		//checks the number of possible moves left
		public function movesLeft():uint {
			var numMoves:uint = 0;
			var i:uint = 0;
			while(i<currentMap.length) {
				var j:uint = 0;
				while(j<currentMap[0].length) {
					if(i>1) {//maybe can hop up
						if(canMove(i,j,i-2,j)) {
							numMoves++;
						}
					}
					if(i<currentMap.length-2) {//maybe can hop down
						if(canMove(i,j,i+2,j)) {
							numMoves++;
						}
					}
					if(j>1) {//maybe can hop left
						if(canMove(i,j,i,j-2)) {
							numMoves++;
						}
					}
					if(j<currentMap[0].length-2) {//maybe can hop right
						if(canMove(i,j,i,j+2)) {
							numMoves++;
						}
					}
					j++;
				}
				i++;
			}
			return numMoves;
		}

		//checks if the position is valid or not (either a 1 or 2)
		public function validPosition(px:uint,py:uint):Boolean {
			var valid:Boolean=true;
			if (px<0||py<0) {
				valid=false;
			} else if (px>currentMap[0].length-1||py>currentMap.length-1) {
				valid=false;
			} else if (currentMap[py][px]==0) {
				valid=false;
			}
			return valid;
		}
		
		//gets the current map
		public function getMap():Array {
			return currentMap;
		}
		
		//gets a copy of the original map
		public function getOriginalMap():Array {
			switch (mapName) {
				case "earth" :
					return copyMap(maps[0]);
					break;
				case "water" :
					return copyMap(maps[1]);
					break;
				case "air" :
					return copyMap(maps[2]);
					break;
				case "fire" :
					return copyMap(maps[3]);
					break;
				default :
				    return null;
			}
		}
		
		//gets the value of a position on the map
		public function getPosition(px:uint,py:uint):int {
			return currentMap[py][px];
		}
		
		//prints the map in a neat fashion (debug only)
		public function printMap():void {
			for(var i:uint = 0;i<currentMap.length;i++) {
				trace(currentMap[i]);
			}
		}
		
		//gets the number of marbles on the map
		public function getMarbleNum():uint {
			var numMarbles:uint = 0;
			for(var i:uint = 0;i<currentMap.length;i++) {
				for(var j:uint = 0;j<currentMap[0].length;j++) {
					if(currentMap[i][j]==2) {
						numMarbles++;
					}
				}
			}
			return numMarbles;
		}
		
		//resets the map
		public function resetMap():void {
			setMap(mapName);
		}
		
		//copies a map
		private function copyMap(map:Array):Array {
			var newMap:Array = new Array();
			for(var i:uint = 0;i<map.length;i++) {
				newMap[i] = new Array();
				for(var j:uint = 0;j<map[i].length;j++) {
					newMap[i][j] = map[i][j];
				}
			}
			return newMap;
		}
	}
}