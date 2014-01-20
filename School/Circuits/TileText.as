//par:DisplayMap
package {
	import flash.display.MovieClip;
	public class TileText extends MovieClip {
		//constructor
		private var px:int;
		private var py:int;
		private var num:Number;
		private var unit:String;
		public function TileText(px:int,py:int,num:Number,unit:String):void {
			this.px = px;
			this.py = py;
			this.num = num;
			this.unit = unit;
			
			x = px;
			y = py;
			textBox.text = String(num)+unit;
		}
	}
}