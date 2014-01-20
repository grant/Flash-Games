//The user-moveable character
//par:Main,...
//children:...
package {
	import flash.display.Sprite;
	public class Player extends Sprite {
		////Parts////
		var body:PlayerBody;
		public function Player() {
			setup();
		}
		
		//setup
		private function setup():void {
			body = new PlayerBody();
			body.scaleX = .5;
			body.scaleY = .5;
			
			//display list
			addChild(body);
		}
	}
}