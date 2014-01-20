//The Player's body (non-visual)
//par:Player
//children:PlayerBodyTorso,PlayerBodyFoot,PlayerBodyHair,PlayerBodyNose,PlayerBodyMouth
package {
	import flash.display.Sprite;
	public class PlayerBody extends Sprite {
		////constants////
		var MODEL:Array;//hash map (index:model #,data:Array(type for torso, type for foot1, etc.))
		////body parts////
		var torso:PlayerBodyTorso;
		var foot1:PlayerBodyFoot;//back foot
		var foot2:PlayerBodyFoot;//front foot
		var hair1:PlayerBodyHair;
		var hair2:PlayerBodyHair;
		var nose:PlayerBodyNose;
		var eyebrows:PlayerBodyEyebrows;
		var leftEye:PlayerBodyEye;
		var rightEye:PlayerBodyEye;
		////properties////
		public function PlayerBody() {
			setup();
		}
		
		//setup
		private function setup():void {
			MODEL = new Array();//torso,foot1,foot2,hair1,hair2,nose,eyebrows,leftEye,rightEye
			MODEL[0] = new Array(0,0,0,0,1,0,0,0,1);
			
			torso = new PlayerBodyTorso();
			foot1 = new PlayerBodyFoot();
			foot2 = new PlayerBodyFoot();
			hair1 = new PlayerBodyHair();
			hair2 = new PlayerBodyHair();
			nose = new PlayerBodyNose();
			eyebrows = new PlayerBodyEyebrows();
			leftEye = new PlayerBodyEye();
			rightEye = new PlayerBodyEye();
			
			setModel(0);
			
			//display list (back to front)
			addChild(foot1);
			addChild(hair1);
			addChild(torso);
			
			addChild(nose);
			addChild(leftEye);
			addChild(rightEye);
			
			addChild(hair2);
			addChild(eyebrows);
			addChild(foot2);
		}
		
		////Setters////
		//sets the types for a predefined model
		public function setModel(modelNumber:uint):void {
			torso.setType(MODEL[modelNumber][0]);
			foot1.setType(MODEL[modelNumber][1]);
			foot2.setType(MODEL[modelNumber][2]);
			hair1.setType(MODEL[modelNumber][3]);
			hair2.setType(MODEL[modelNumber][4]);
			nose.setType(MODEL[modelNumber][5]);
			eyebrows.setType(MODEL[modelNumber][6]);
			leftEye.setType(MODEL[modelNumber][7]);
			rightEye.setType(MODEL[modelNumber][8]);
		}
	}
}