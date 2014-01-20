package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Upgrade extends MovieClip {
		public function Upgrade() {
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			if(this.currentFrame==totalFrames){
				stop();
			}
		}
	}
}