package {
	import flash.display.MovieClip;
	public class Tile extends MovieClip {
		//constructors
		private var id:uint;
		private var rot:uint;
		private var px:int;
		private var py:int;
		private var size:uint;
		public function Tile(id:uint,rot:uint,px:int,py:int,size:uint):void {
			this.id = id;
			this.rot = rot;
			this.px = px;
			this.py = py;
			this.size = size;
			
			gotoAndStop(id+1);
			rotation = rot;
			x = px;
			y = py;
			//width = size;//to fix glitch
			//height = size;//to fix glitch
		}
	}
}