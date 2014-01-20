//The driver class of the project
package Main {
	import flash.display.MovieClip;
	
	import Player.Player;
	import Player.PlayerBodyTorso;
	public class Main extends MovieClip {
		public function Main():void {
			addPlayer();
		}
		
		//add a test player
		private function addPlayer():void {
			var p:Player = new Player();
			p.x = 100;
			p.y = 400;
			addChild(p);
			
			addChild(new PlayerBodyTorso());
		}
	}
}