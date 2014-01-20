package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class ToBlack extends MovieClip {
		var fname:String;
		public function ToBlack(funct:String) {
			fname = funct;
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			if(currentFrame==totalFrames){
				remove();
			} else {
				gotoAndStop(currentFrame+1);
			}
		}
		public function remove():void {
			MovieClip(parent).callFunct(fname);
			removeEventListener(Event.ENTER_FRAME,onLoop);
			parent.removeChild(this);
		}
	}
}