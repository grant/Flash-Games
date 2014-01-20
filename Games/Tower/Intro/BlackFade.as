package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class BlackFade extends MovieClip {
		public function BlackFade():void {
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			if(currentFrame==10){
				stop();
			} else if(currentFrame==20){
				removeEventListener(Event.ENTER_FRAME,onLoop);
				MovieClip(parent).removeChild(this);
			}
		}
	}
}