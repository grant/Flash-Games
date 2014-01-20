package {
	import flash.display.MovieClip;
	public class ScoreNumber extends MovieClip {
		private var scale:Number;
		private var px:uint;
		private var py:uint;
		public function ScoreNumber(px:uint,py:uint,scale:Number):void {
			this.px = px;
			this.py = py;
			this.scale = scale;
			this.scaleX = scale;
			this.scaleY = scale;
			x = px;
			y = py;
			setText();
		}
		
		//sets text options
		private function setText():void {
			num.selectable = false;
		}
		
		//changeNum
		public function changeNum(number:uint):void {
			num.text = String(number);
		}
	}
}