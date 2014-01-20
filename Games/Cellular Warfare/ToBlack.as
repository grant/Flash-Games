package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class ToBlack extends MovieClip {
		public function ToBlack() {
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			if(this.currentFrame==10){
				stop();
			}
		}
	}
}