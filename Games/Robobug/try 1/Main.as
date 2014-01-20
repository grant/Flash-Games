//Driver class
/*
Todo:

-DESIGN A GAME ON PAPER

Notes:

-Have the player be able to have some type of money
-Have the player be able to create blocks that serve as income per second harvesters.
-Have the player be abel to create blocks that act as a sheild.
-Have upgrades buyable from money
*/
package {
	import flash.display.MovieClip;
	[SWF(backgroundColor="0xFFFFFF" , width="700" , height="500", frameRate="25")]
	public class Main extends MovieClip {
		public static var GAME:Game;
		public function Main():void {
			setup();
		}
		
		//sets up the game
		private function setup():void {
			GAME = new Game();
			addChild(GAME);
			//settings
			stage.showDefaultContextMenu = false;
		}
	}
}