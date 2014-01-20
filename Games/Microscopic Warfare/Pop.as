package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Pop extends Sprite {
		public function Pop(xPos:int,yPos:int) {
			x = xPos;
			y = yPos;
			width = 1;
			height = 1;
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			width += (20-width)*.5;
			height += (20-height)*.5;
			x -= MovieClip(parent).cellXS;
			y -= MovieClip(parent).cellYS;
			if(width>10){
				alpha -=.1;
			}
			if(alpha <=0){
				removeEventListener(Event.ENTER_FRAME,onLoop);
				MovieClip(parent).removeChild(this);
			}
		}
	}
}