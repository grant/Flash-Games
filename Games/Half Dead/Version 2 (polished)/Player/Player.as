//The character player that moves and shoots things
//par:Main
//child:PlayerBody
//child:PlayerEquippedItem
package Player {
	import flash.display.MovieClip;
	
	import Player.PlayerBody;
	public class Player extends MovieClip {
		////
		//Constants
		////
		
		////
		//Parts
		////
		private var playerBody:PlayerBody;//the body piece of the player
		//properties
		public function Player():void {
			setup();
		}
		
		////
		//Setups
		////
		
		//sets up the player
		//sets up in order of layers
		//greatest z index to lowest z index
		private function setup():void {
			setConstants();
			setBody();
		}
		
		//sets up constants for the player
		private function setConstants():void {
			
		}
		
		//sets up the body
		private function setBody():void {
			playerBody = new PlayerBody();
			addChild(playerBody);
		}
		
		////
		//Setters
		////
		
		//sets the player's x
		public function setX(px:Number):void {
			x = px;
		}
		//sets the player's y
		public function setY(py:Number):void {
			y = py;
		}
		
		////
		//Getters
		////
		
		//gets the player's x
		public function getX():Number {
			return x;
		}
		//gets the player's y
		public function getY():Number {
			return y;
		}
	}
}