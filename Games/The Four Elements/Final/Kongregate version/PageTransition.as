package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class PageTransition extends MovieClip {
		private const BLACK:uint = 30;//frame number of 100 alpha
		private const TO_BLACK:uint = 0;//frame number of 0 alpha going to 100 alpha
		private const FROM_BLACK:uint = 60;//frame numbe rof 0 alpha from 100 alpha
		
		private var desFrame:uint = 0;
		public function PageTransition():void {
			stop();
			mouseEnabled = false;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			addEventListener(Event.ENTER_FRAME,onLoop);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//continually updages the transition
		private function onLoop(e:Event):void {
			if(currentFrame!=desFrame) {
				gotoAndStop(currentFrame+1);
			}
		}
		
		//goes from black to alpha
		public function goFromBlack():void {
			gotoAndStop(BLACK);
			desFrame = FROM_BLACK;
		}
		
		//goes from alpha to black
		public function goToBlack():void {
			gotoAndStop(TO_BLACK);
			desFrame = BLACK;
		}
		
		//if transitioning or not
		public function isTransitioning():Boolean {
			return currentFrame!=desFrame;
		}
	}
}