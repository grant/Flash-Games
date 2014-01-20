/*
Notes:
-MVC STYLE!!!
-Separate and perfect
*/
//parents:stage
//children:WorldViewer
//Model
package {
	import flash.display.MovieClip;
	[SWF(backgroundColor="0xFFFFFF" , width="700" , height="500", frameRate="25")]
	public class Main extends MovieClip {
		private var worldViewer:WorldViewer;
		public function Main():void {
			setup();
		}
		private function setup():void {
			setWorldViewer();
			setSettings();
		}
		
		//sets the world viewer
		private function setWorldViewer():void {
			worldViewer = new WorldViewer(new World());
			addChild(worldViewer);
		}
		
		//sets the settings
		private function setSettings():void {
			stage.showDefaultContextMenu = false;
		}
	}
}