package {
	import flash.display.Sprite;
	public class Ground extends Sprite {
		private var xPos:int;
		private var yPos:int;
		private var wid:uint;
		private var hei:uint;
		public function Ground(xPos:int,yPos:int,wid:uint,hei:uint) {
			x = xPos;
			y = yPos;
			width = wid;
			height = hei;
		}
	}
}