//parents:Main
//children:World
//M
//controls all models for the world
package {
	import flash.display.MovieClip;
	public class WorldViewer extends MovieClip {
		private var world;
		public function WorldViewer(world):void {
			this.world = world;
			addChild(world);
		}
		
		//
		//GETTERS
		//
		public function getWorld():World {
			return world;
		}
		
		//
		//SETTERS
		//
		public function setWorld(world:World):void {
			this.world = world;
		}
	}
}