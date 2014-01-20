//parents:World
//children:
//M
//Stores information about the tiles of a world
package {
	import flash.display.MovieClip;
	public class TilesModel extends MovieClip {
		private const DIMENSION_SIZE:uint = 16;//the size of any dimension N x N
		//map properties (updated when changed)
		private var map:Array;//2d array of num_dimensions
		private var numDimensions:uint = 0;//the number of dimesions there are currently in this tile model
		private var mapWidth:uint = 0;//the technical width of the map
		private var mapHeight:uint = 0;//the technical height of the map
		private var mapWidthBound:uint = 0;//the actual width of the map (most right tile position-most left tile position)
		private var mapHeightBound:uint = 0;//the actual height of the map (lowest tile position-highest tile position)
		private var numberOfTiles:uint = 0;//the number of non-empty tiles
		//map changes?
		
		/*
		How the map engine works:
		Goal: Make a map that uses minimal resources but can be huge, even infinite (o.o)
		Explanation:
		-Take a normal grid of tiles 353x457
		-take each 16x16 and put that in an array
		-take each 16x16 of that and put it in an array, dimension #2
		-don't take the 16x16 if is blank, leave the array with no child array
		-do this until you have the full map
		*/
		
		
		/*
		//Code for encoding/decoding:
		
		public static function encode(ba:ByteArray):String {
    var origPos:uint = ba.position;
    var result:Array = new Array();

    for (ba.position = 0; ba.position < ba.length - 1; )
        result.push(ba.readShort());

    if (ba.position != ba.length)
        result.push(ba.readByte() << 8);

    ba.position = origPos;
    return String.fromCharCode.apply(null, result);
}

public static function decode(str:String):ByteArray {
    var result:ByteArray = new ByteArray();
    for (var i:int = 0; i < str.length; ++i) {
        result.writeShort(str.charCodeAt(i));
    }
    result.position = 0;
    return result;
}
*/
		public function TilesModel():void {
			map = new Array();
			for(var i:uint=0;i<16;i++) {
				map[i] = new Array();
				for(var j:uint=0;j<16;j++) {
					map[i][j] = 2;
				}
			}
			trace(getNumberOfTiles());
		}
		
		//
		//GETTERS
		//
		
		//gets the number of non-empty tiles (getNumberOfTiles()) DONE
		public function getNumberOfTiles():uint {
			return getTiles(map);
		}
		private function getTiles(a:Array):int {
			var numTiles:uint = 0;
			for(var i:uint = 0;i<DIMENSION_SIZE;i++) {
				for(var j:uint = 0;j<DIMENSION_SIZE;j++) {
					if(typeof a[j][i]=="number") {//tile id
						numTiles++;
					} else if(typeof a[j][i]=="object"&&a[j][i]!=null) {//array
						numTiles += getTiles(a[j][i]);//recursive!
					}//else null
				}
			}
			numberOfTiles = numTiles;
			return numTiles;
		}
		
		//SIZE
		//gets the number of dimensions of the map (getNumDimensions()) UNDONE
		public function getNumDimensions():uint {
			return numDimensions;
		}
		//gets the technical width of the map (getMapWidth()) DONE, NEEDS getNumDimensions()
		public function getMapWidth():uint {
			return Math.pow(DIMENSION_SIZE,getNumDimensions());
		}
		//gets the technical height of the map (getMapHeight()) DONE, NEEDS getNumDimensions()
		public function getMapHeight():uint {
			return getMapWidth();
		}
		//gets the width of the map (getMapWidthBound()) UNDONE, NOT NEEDED
		public function getMapWidthBound():uint {
			var left:int=-1;
			var right:int=-1;
			while(left<0) {
				
			}
			while(right<0) {
				
			}
			return (right-left);
			for(var i:uint=0;i<NUM_DIMENSIONS;i++) {
				for(var j:uint=0;j<NUM_DIMENSIONS;j++) {
					
				}
			}
		}
		
		//
		//SETTERS
		//
		
	}
}