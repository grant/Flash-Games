//par:Page
package {
	import flash.display.MovieClip;
	public class Circuit extends MovieClip {
		//constants
		private const MAP_X:int = 225;
		private const MAP_Y:int = 25;
		private const MAP_WID:uint = 12;
		private const MAP_HEI:uint = 12;
		private const MAP_SIZE:uint = 50;
		//variables
		private var map:Map;
		private var displayMap:DisplayMap;
		public function Circuit():void {
			setUp();
		}
		
		//sets up the circuit gui
		private function setUp():void {
			//map
			map = new Map(MAP_WID,MAP_HEI);
			//display map
			displayMap = new DisplayMap(MAP_X,MAP_Y,MAP_WID,MAP_HEI,MAP_SIZE);
			displayMap.addMap(map);
			addChild(displayMap);
		}
	}
}