package {
	import flash.display.MovieClip;
	public class EmptySpace extends MovieClip {
		public function EmptySpace(px:int,py:int):void {
			x = px;
			y = py;
			cacheAsBitmap = true;
			mouseEnabled = false;
		}
		
		//sets the size of the tile
		public function setWidHei(size:uint):void {
			this.width = size;
			this.height = size;
		}
	}
}