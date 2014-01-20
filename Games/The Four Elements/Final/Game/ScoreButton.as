//par2:Page
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class ScoreButton extends MovieClip {
		private var px:uint;
		private var py:uint;
		private var appearing:Boolean = false;
		private var disabled:Boolean = false;
		
		private var par:MovieClip;
		private var par2:MovieClip;
		public function ScoreButton(px:uint,py:uint):void {
			this.px = px;
			this.py = py;
			x = px;
			y = py;
			stop();
			buttonMode = true;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			par2 = MovieClip(parent.parent);
			addEventListener(MouseEvent.CLICK,onClick);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//when clicked
		private function onClick(e:MouseEvent):void {
			if(!disabled) {
				par2.gotoScores();
			}
		}
		
		//makes invisible
		public function disappear():void {
			visible = false;
			disabled = true;
		}
		
		//make visible
		public function appear():void {
			disabled = false;
			if(!appearing) {
				appearing = true;
				visible = true;
				alpha = 0;
				addEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
		private function onLoop(e:Event):void {
			if(alpha<1) {
				alpha+=.01;
			} else {
				alpha = 1;
				removeEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
		
		//removes the button
		public function remove():void {
			par.removeChild(this);
		}
	}
}
	