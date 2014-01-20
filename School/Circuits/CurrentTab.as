package {
	import flash.display.MovieClip;
	public class CurrentTab extends MovieClip {
		//constructors
		private var tabNum:int;
		private var px:int;
		private var py:int;
		private var wid:uint;
		private var hei:uint;
		//par
		private var par:MovieClip;
		public function CurrentTab(tabNum:int,px:int,py:int,wid:uint,hei:uint):void {
			this.tabNum = tabNum;
			this.px = px;
			this.py = py;
			this.wid = wid;
			this.hei = hei;
			
			gotoAndStop(tabNum+1);
			x = px;
			y = py;
			width = wid;
			height = hei;
		}
		
		//turns off the current tab
		public function turnOff():void {
			this.visible = false;
		}
		
		//turns on the current tab
		public function turnOn():void {
			this.visible = true;
		}
	}
}