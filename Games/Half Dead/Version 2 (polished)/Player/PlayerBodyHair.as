//The hair/top feature of the body
//par:PlayerBody
package Player {
	import flash.display.MovieClip
	public class PlayerBodyHair extends PlayerFeature {
		////
		//Constants
		////
		public function PlayerBodyHair():void {
			setConstants();
			super();
		}
		
		//sets up the constants
		private function setConstants():void {
			//sets up arrays
			//arrays have indexes which represent (frame_number-1) and an array which represents x and y values
			POSITIONS = new Array();
			POSITIONS[0] = new Array(0,0);
			//POSITIONS[1]...
		}
	}
}