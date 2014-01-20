//par:Main
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.SharedObject;
	public class Scores extends MovieClip {
		private var scores:Array;
		private var restarts:uint = 0;//the number of restarts
		private var jumps:uint = 0;//the number of marble jumps
		private var scoresPassingLimit:Array;
		private var shared:SharedObject;//shared object
		private var par:MovieClip;
		
		public function Scores():void {
			setScoresPassingLimit();
			setScores();
			getSharedObjectScores();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		public function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//gets shared object scores
		private function getSharedObjectScores():void {
			shared = SharedObject.getLocal("elements");
			//restarts
			if (shared.data.restarts==undefined) {
				shared.data.restarts = 0;
			} else {
				restarts = shared.data.restarts;
			}
			//jumps
			if (shared.data.jumps==undefined) {
				shared.data.jumps = 0;
			} else {
				jumps = shared.data.jumps;
			}
			//scores
			if (shared.data.earth==undefined) {
				shared.data.earth = scores[0];
			} else {
				scores[0] = shared.data.earth;
			}
			if (shared.data.water==undefined) {
				shared.data.water = scores[1];
			} else {
				scores[1] = shared.data.water;
			}
			if (shared.data.air==undefined) {
				shared.data.air = scores[2];
			} else {
				scores[2] = shared.data.air;
			}
			if (shared.data.fire==undefined) {
				shared.data.fire = scores[3];
			} else {
				scores[3] = shared.data.fire;
			}
			shared.close();
		}
		
		//sets the passing limit for each level
		private function setScoresPassingLimit():void {
			scoresPassingLimit = new Array();
			scoresPassingLimit[0] = 6;
			scoresPassingLimit[1] = 6;
			scoresPassingLimit[2] = 8;
			scoresPassingLimit[3] = 6;
		}
		
		//sets scores
		public function setScores():void {
			scores = new Array();
			scores[0] = 44;
			scores[1] = 40;
			scores[2] = 64;
			scores[3] = 68;
		}
		
		//adds a score
		public function addScore(score:uint,mapName:String):void {
			var id:uint;
			switch(mapName) {
				case "earth" :
					id = 0;
					break;
				case "water" :
					id = 1;
					break;
				case "air" :
					id = 2;
					break;
				case "fire" :
					id = 3;
					break;
			}
			//disappear instructions
			if(mapName=="earth"&&score==30) {
				if(par.getPage().getInstructionLabel().getVisibility!=1) {
					par.getPage().getInstructionLabel().setDisappearTime(20);
					par.getPage().getInstructionLabel().disappear();
				}
			}
			scores[id] = Math.min(scores[id],score);
			//update score board
			if(scores[id]<=scoresPassingLimit[id]) {
				par.getPage().updateLevelsUnlocked(id+2);
			}
			par.getPage().getScoreBoard().updateHighScore(scores[id]);
			par.getPage().getScoreBoard().updateCurrentScore(score);
			updateSharedObject();
		}
		
		//gets a score
		public function getScore(mapName):int {
			switch(mapName) {
				case "earth" :
					return scores[0];
					break;
				case "water" :
					return scores[1];
					break;
				case "air" :
					return scores[2];
					break;
				case "fire" :
					return scores[3];
					break;
				default:
					return -1;
			}
		}
		
		//traces all scores
		public function traceAllScores():void {
			trace("Earth: "+scores[0]);
			trace("Water: "+scores[1]);
			trace("Air: "+scores[2]);
			trace("Fire: "+scores[3]);
		}
		
		//returns if the scores is a high score
		public function isHighScore(score:uint,mapName:String):Boolean {
			switch(mapName) {
				case "earth" :
					return scores[0]==score;
					break;
				case "water" :
					return scores[1]==score;
					break;
				case "air" :
					return scores[2]==score;
					break;
				case "fire" :
					return scores[3]==score;
					break;
				default :
					return false;
			}
		}
		
		//adds one to the restarts number
		public function addRestartScore():void {
			restarts++;
			updateSharedObject();
		}
		
		//gets the number of restarts
		public function getRestarts():uint {
			return restarts;
		}
		
		//get the total score
		public function getTotalScore():uint {
			return (scores[0]+scores[1]+scores[2]+scores[3]);
		}
		
		//add a jump score point
		public function addJumpScore():void {
			jumps++;
			updateSharedObject();
		}
		
		//gets the jump score
		public function getJumps():uint {
			return jumps;
		}
		
		//updates the shared object
		private function updateSharedObject():void {
			shared = SharedObject.getLocal("elements");
			shared.data.restarts = restarts;
			shared.data.jumps = jumps;
			shared.data.earth = scores[0];
			shared.data.water = scores[1];
			shared.data.air = scores[2];
			shared.data.fire = scores[3];
		}
	}
}