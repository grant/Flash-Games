package {
	import flash.display.MovieClip;
	public class Tile extends MovieClip {
		private var f:uint;
		public function Tile(frame:uint,xPos:int,yPos:int,wid:uint,hei:uint) {
			f=frame;
			gotoAndStop(f);
			x = xPos;
			y = yPos;
			width = wid;
			height = hei;
		}
	}
}