package {
	import flash.display.MovieClip;
	public class Main extends MovieClip {
		//Maps//
		public static var maps:Array;
		public var map1:Array;
		public static var currentMap:Array;
		//Tile//
		public const tileXOffset = 10;
		public const tileYOffset = 10;
		public const tileWidth = 20;
		public const tileHeight = 20;
		//
		public function Main() {
			setMaps();
			loadMap(1);
		}
		private function setMaps(){
			//Levels//
			map1 = new Array();
			map1[0]=[1,1,2];
			map1[1]=[2,1,1];
			//Map Holder//
			maps = new Array();
			maps[0]=map1;
		}
		private function loadMap(mapNumber:uint):void {
			mapNumber--;
			currentMap = new Array();
			for(var a:uint=0;a<maps[mapNumber][0].length;a++){//width
				currentMap[a] = new Array();
				for(var b:uint=0;maps[mapNumber].length;b++){//height
					currentMap[a][b] = new Tile(maps[mapNumber][a][b],tileXOffset+(a*tileWidth),tileYOffset+(b*tileHeight),tileWidth,tileHeight);
					addChild(currentMap[a][b]);
				}
			}
		}
	}
}