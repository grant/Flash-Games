//A feature of the body (cannot be implemented, only extended)
//par:PlayerBody,PlayerBodyTorso,PlayerBodyNose,PlayerBodyHair
package Player {
	import flash.display.MovieClip
	public class PlayerFeature extends MovieClip {
		////
		//Constants
		////
		const DEFAULT_TYPE:uint = 0;
		var POSITIONS:Array;
		public function PlayerFeature():void {
			stop();
			setType(DEFAULT_TYPE);
		}
		
		////
		//Setters (public)
		////
		
		//sets the type of feature (index)
		public function setType(type:uint):void {
			gotoAndStop(type+1);
			x = POSITIONS[type];
			y = POSITIONS[type];
		}
	}
}