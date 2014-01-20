package {
	import flash.display.MovieClip;
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
		public function ScoreBoard(px:uint,py:uint):void {
			this.px;
			this.py;
			x = px;
			y = py;
			addNumbers();
		}
		
		//adds score numbers
		private function addNumbers():void {
			bestScoreNumber = new ScoreNumber(bestScoreX,bestScoreY,bestScoreScale);
			addChild(bestScoreNumber);
			currentScoreNumber = new ScoreNumber(currentScoreX,currentScoreY,1);
			addChild(currentScoreNumber);
		}
		
		//updates the current score
		public function updateCurrentScore(score:uint):void {
			currentScoreNumber.changeNum(score);
		}
		
		//sets the high score
		public function updateHighScore(score:uint):void {
			bestScoreNumber.changeNum(score);
		}
	}
}