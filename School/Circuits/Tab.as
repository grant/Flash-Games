//par:Main
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Tab extends MovieClip {
		//constructors
		private var tabNum:int;
		private var px:int;
		private var py:int;
		private var wid:uint;
		private var hei:uint;
		//par
		private var par:MovieClip;
		public function Tab(tabNum:int,px:int,py:int,wid:uint,hei:uint):void {
			this.tabNum = tabNum;
			this.px = px;
			this.py = py;
			this.wid = wid;
			
			gotoAndStop(tabNum+1);
			x = px;
			y = py;
			width = wid;
			height = hei;
			
			this.buttonMode = true;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			//parent
			par = MovieClip(parent);
			//events
			addEventListener(MouseEvent.CLICK,onClick);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//when the tab is clicked
		private function onClick(e:Event):void {
			par.toTab(tabNum);
		}
		
		//gets the number of possible tabs
		public function getTotalTabs():uint {
			return totalFrames;
		}
	}
}