/*
Notes:
-Do not use OOP: cannot create display objects
-USE INTERFACES to standardize classes
-Make classes fluid and able to be parented/childrened
*/

//The driver class
//par:none
//children:player,...
package {
	import flash.display.MovieClip;
	public class Main extends MovieClip {
		public function Main():void {
			setup();
		}
		
		//setup
		private function setup():void {
			var p:Player = new Player();
			p.x = 200;
			p.y = 300;
			addChild(p);
		}
	}
}