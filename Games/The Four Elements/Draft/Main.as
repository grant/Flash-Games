package {
	import flash.display.MovieClip;
	public class Main extends MovieClip {
		public function Main() {
			stage.showDefaultContextMenu = false;
			var game:Game = new Game();
			addChild(game);
		}
	}
}