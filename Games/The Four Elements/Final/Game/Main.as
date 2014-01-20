package {
	import flash.display.MovieClip;
	public class Main extends MovieClip {
		private var score:Scores;
		private var musicPlayer:MusicPlayer;
		private var page:Page;
		public function Main():void {
			addScores();
			addPage();
			addMusic();
			setMenu();
		}
		
		//add a high score
		private function addScores():void {
			score = new Scores();
			addChild(score);
		}
		
		//starts the game from the title screen
		private function addPage():void {
			page = new Page("title screen");
			page.fromBlack();
			page.setNextPage("earth page");
			page.gotoNextPage(130);
			addChild(page);
		}
		
		//adds music
		private function addMusic():void {
			musicPlayer = new MusicPlayer(this.loaderInfo.loaderURL);
		}
		
		//sets up the right click menu
		private function setMenu():void {
			stage.showDefaultContextMenu = false;
		}
		
		//gets the score
		public function getScore():Scores {
			return score;
		}
		
		//gets the page
		public function getPage():Page {
			return page;
		}
		
		//gets the music player
		public function getMusicPlayer():MusicPlayer {
			return musicPlayer;
		}
	}
}