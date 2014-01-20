//Data for the world map
/* Public methods
inBounds(pt)
getMapWidth()
getMapHeight()
getTileId()
getMapArray()
getCode()
*/
package {
	import flash.display.MovieClip;
	import flash.geom.Point;
	public class WorldMap extends MovieClip {
		private var map:Array;
		//types of tiles (a tile can have more than one type)
		private var groundTiles:Array;//a list of tileIds that are support a falling char
		private var ceilingTiles:Array;//a list of tilesIds that block a jumping char
		private var wallTiles:Array;//a list of tileIds that stop horizontal movement upon touch
		public function WorldMap():void {
			setup();
		}

		//sets up the maps
		private function setup():void {
			//creates an example map
			/*
			var chance:Number = .8;
			map = new Array();
			for(var i:uint = 0;i<100;i++) {
				map[i] = new Array();
				for(var j:uint =0;j<100;j++) {
					var tile:int = Math.floor(Math.random()+chance);
					map[i][j] = tile;
				}
			}
			*/
			///*
			map=[[1,1,0,0,0,0,0,0,0,0,1,0,0],
			     [0,1,1,1,0,0,0,0,0,0,0,0,0],
				 [0,0,0,0,0,0,0,0,0,0,0,0,0],
				 [0,1,1,1,0,1,1,0,1,0,0,0,1],
				 [1,1,1,1,1,1,1,1,0,1,0,1,1]];
			//*/

			//tile types
			groundTiles = [1];
			ceilingTiles = [1];
			wallTiles = [1];
		}

		//
		//CHECKERS
		//

		//checks if the point is in bounds
		public function inBounds(pt:Point):Boolean {
			var good:Boolean=true;
			//if out of bounds
			if (pt.x<0||pt.y<0||pt.x>=getMapWidth()||pt.y>=getMapHeight()) {
				good=false;
			}
			return good;
		}

		//gets whether the tile is a ground tile
		public function isGroundTile(tileId:uint):Boolean {
			return arrayHasValue(tileId,groundTiles);
		}
		//gets whether the tile is a ceiling tile
		public function isCeilingTile(tileId:uint):Boolean {
			return arrayHasValue(tileId,ceilingTiles);
		}
		//gets whether the tile is a wall tile
		public function isWallTile(tileId:uint):Boolean {
			return arrayHasValue(tileId,wallTiles);
		}
		public function arrayHasValue(val:uint,array:Array):Boolean {
			var b:Boolean = false;
			var i:uint = 0;
			while(!b&&i<array.length) {
				//trace("Here",array,i);
				if(array[i]==val) {
					b = true;
				}
				i++;
			}
			return b;
		}

		//
		//SETTERS
		//

		//
		//GETTERS
		//

		//gets the map width
		public function getMapWidth():uint {
			return map[0].length;
		}

		//gets the map height
		public function getMapHeight():uint {
			return map.length;
		}

		//gets the tile id from a certain position, returns -1 if not valid pt
		public function getTileId(pt:Point):int {
			if (! inBounds(pt)) {
				return -1;
			} else {
				return map[pt.y][pt.x];
			}
		}

		//gets the map array
		public function getMapArray():Array {
			return map;
		}

		//gets the map array as code
		public function getCode():String {
			var s:String="";
			s+="[";
			//middle
			for (var i:uint = 0; i<getMapHeight()-1; i++) {
				s+="[";
				s+=map[i];
				s+="],";
			}
			//one without comma at end
			s+="[";
			s+=map[i];
			s+="]";
			//end middle
			s+="]";
			return s;
		}
	}
}