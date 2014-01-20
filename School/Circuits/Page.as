//par:Main
package {
	import flash.display.MovieClip;
	public class Page extends MovieClip {
		//constructor
		private var px:uint;
		private var py:uint;
		public function Page(px:uint,py:uint):void {
			this.px = px;
			this.py = py;
			
			x = px;
			y = py;
			
			stop();
		}
		
		//goes to a certain page
		public function toPage(pageNum:uint):void {
			gotoAndStop(pageNum+1);
		}
	}
}