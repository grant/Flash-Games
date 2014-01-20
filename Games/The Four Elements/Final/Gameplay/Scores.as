package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Scores extends MovieClip {
		private var scores:Array;
		private var par:MovieClip;
		public function Scores():void {
			setScores();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//sets scores
		private function setScores():void {
			scores = new Array();
			scores[0] = 999;
			scores[1] = 999;
			scores[2] = 999;
			scores[3] = 999;
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
			scores[id] = Math.min(scores[id],score);
			par.getScoreBoard().updateHighScore(scores[id]);
			par.getScoreBoard().updateCurrentScore(score);
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
	}
}