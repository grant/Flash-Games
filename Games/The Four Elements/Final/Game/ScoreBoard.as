//par:Page
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class ScoreBoard extends MovieClip {
		//constants
		private const bestScoreScale:Number = 0.38;
		private const bestScoreX:uint = 16;
		private const bestScoreY:uint = 18;
		private const currentScoreX:uint = 51;
		private const currentScoreY:uint = 33;
		
		//constructors
		private var px:uint;
		private var py:uint;
		
		//numbers
		private var bestScoreNumber:ScoreNumber;
		private var currentScoreNumber:ScoreNumber;
		
		//score board labels
		private var scoresLabel:CustomLabel;
		
		//parent
		private var par:MovieClip;
		public function ScoreBoard(px:uint,py:uint):void {
			this.px;
			this.py;
			x = px;
			y = py;
			addNumbers();
			addLabels();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//adds score numbers
		private function addNumbers():void {
			bestScoreNumber = new ScoreNumber(bestScoreX,bestScoreY,bestScoreScale);
			addChild(bestScoreNumber);
			currentScoreNumber = new ScoreNumber(currentScoreX,currentScoreY,1);
			addChild(currentScoreNumber);
		}
		
		//adds the score board label
		private function addLabels():void {
			scoresLabel = new CustomLabel(1,true);
			addChild(scoresLabel);
			addEventListener(MouseEvent.ROLL_OVER,mouseRollOver);
		}
		
		//if the mouse moves over the score board
		private function mouseRollOver(e:MouseEvent):void {
			scoresLabel.appear();
		}
		
		//updates the current score
		public function updateCurrentScore(score:uint):void {
			currentScoreNumber.changeNum(score);
		}
		
		//sets the high score
		public function updateHighScore(score:uint):void {
			bestScoreNumber.changeNum(score);
		}
		
		//removes the scoreboard
		public function remove():void {
			par.removeChild(this);
		}
	}
}