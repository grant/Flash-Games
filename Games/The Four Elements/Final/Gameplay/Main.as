package {
	import flash.display.MovieClip;
	public class Main extends MovieClip {
		private var score:Scores;
		private var game:Game;
		private var scoreBoard:ScoreBoard;
		private var musicPlayer:MusicPlayer;
		public function Main():void {
			addScores();
			addScoreBoard();
			addGame();
			addMusic();
		}
		
		//adds the game to the screen
		private function addGame():void {
			game = new Game("earth");
			addChild(game);
		}
		
		//adds the score board to the screen
		private function addScoreBoard():void {
			scoreBoard = new ScoreBoard(60,40);
			addChild(scoreBoard);
		}
		
		//add a high score
		private function addScores():void {
			score = new Scores();
			addChild(score);
		}
		
		//gets the high score
		public function getScore():Scores {
			return score;
		}
		
		//gets the score board
		public function getScoreBoard():ScoreBoard {
			return scoreBoard;
		}
		
		//adds music
		private function addMusic():void {
			musicPlayer = new MusicPlayer();
		}
	}
}