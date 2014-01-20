package {
	import flash.display.MovieClip;
	public class Main extends MovieClip {
		private var page:Page;
		public function Main():void {
			startGame();
			setMenu();
		}
		
		//starts the game from the title screen
		private function startGame():void {
			page = new Page("title screen");
			page.fromBlack();
			page.setNextPage("earth page");
			page.gotoNextPage(130);
			addChild(page);
		}
		
		//sets up the right click menu
		private function setMenu():void {
			stage.showDefaultContextMenu = false;
		}
	}
}