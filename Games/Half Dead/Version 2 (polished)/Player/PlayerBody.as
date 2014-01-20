//The visual body of the player (torso, hands, feet, gun)
//par:Player
package Player {
	import flash.display.MovieClip;
	
	import Player.PlayerBodyTorso;
	public class PlayerBody extends PlayerFeature {
		////
		//Constants
		////
		
		////
		//Parts (MovieClips)
		////
		var playerBodyTorso:PlayerBodyTorso;
		
		public function PlayerBody() {
			setConstants();
			super();
			setup();
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
		private function setup():void {
			setupTorso();
		}
		private function setupTorso():void {
			playerBodyTorso = new PlayerBodyTorso();
			addChild(playerBodyTorso);
		}
		
		////
		//Methods
		////
	}
}
/*
foot1=new Foot1(1);
			addChild(foot1);


			body = new Body();
			addChild(body);

			nose=new Nose(1,25,-35);//frame #,x,y
			addChild(nose);

			eye1=new Eye(1,10,-60);//frame #,x,y
			addChild(eye1);

			eye2=new Eye(1,45,-60);//frame #,x,y
			addChild(eye2);

			foot2=new Foot2(1);
			addChild(foot2);

			hair=new Hair(2);
			addChild(hair);

			eyebrow1=new Eyebrow(1,10,-80);//frame #,x,y
			addChild(eyebrow1);

			eyebrow2=new Eyebrow(2,45,-80);//frame #,x,y
			addChild(eyebrow2);
*/