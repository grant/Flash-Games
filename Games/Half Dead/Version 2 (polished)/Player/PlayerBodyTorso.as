//The main torso of the body
//par:PlayerBody
package Player {
	import flash.display.MovieClip
	public class PlayerBodyTorso extends PlayerFeature {
		////
		//Constants
		////
		var PLAYER_BODY_TORSO_POSITIONS:Array;//multiple positions for torsos
		////
		//Parts (MovieClips)
		////
		var playerBodyNose:PlayerBodyNose;
		var playerBodyHair:PlayerBodyHair;
		////
		//Properties
		////
		var type:uint = 0;
		public function PlayerBodyTorso():void {
			setConstants();
			super();
			setupParts();
		}
		
		//sets up the constants
		private function setConstants():void {
			//sets up arrays
			//arrays have indexes which represent (frame_number-1) and an array which represents x and y values
			POSITIONS = new Array();
			POSITIONS[0] = new Array(0,0);
			//POSITIONS[1]...
		}
		
		//sets up the player's body parts
		//sets up in order of layers
		//greatest z index to lowest z index
		private function setupParts():void {
			playerBodyHair = new PlayerBodyHair();
			playerBodyNose = new PlayerBodyNose();
			
			addChild(playerBodyHair);
			addChild(playerBodyNose)
			
		}
		private function setupTorso():void {
			
		}
		
		////
		//Setters
		////
		
	}
}