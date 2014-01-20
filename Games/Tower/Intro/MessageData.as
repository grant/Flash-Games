package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class MessageData extends MovieClip {
		private const fadeInSpeed:Number = .1;
		private const fadeOutSpeed:Number = .25;
		public function MessageData(msg:uint):void {
			alpha = 0;
			x = -170;
			y = -140;
			gotoAndStop(msg);
			addEventListener(Event.ENTER_FRAME,fadeIn);
		}
		public function remove():void {
			addEventListener(Event.ENTER_FRAME,fadeOut);
		}
		private function fadeIn(e:Event):void {
			if(alpha<1){
				alpha+=fadeInSpeed;
			} else {
				removeEventListener(Event.ENTER_FRAME,fadeIn);
			}
		}
		private function fadeOut(e:Event):void {
			if(alpha>0){
				alpha-=fadeOutSpeed;
			} else {
				removeEventListener(Event.ENTER_FRAME,fadeOut);
				MovieClip(parent).removeChild(this);
			}
		}
	}
}