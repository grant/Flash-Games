package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Credits extends MovieClip {
		private var par:MovieClip;
		public function Credits():void {
			stop();
			addEventListener(MouseEvent.CLICK,createMessage);
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(MouseEvent.ROLL_OVER,onRollingIn);
			addEventListener(MouseEvent.ROLL_OUT,onRollingOut);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent.parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onRollingIn(e:MouseEvent):void {
			gotoAndStop(2);
		}
		private function onRollingOut(e:MouseEvent):void {
			gotoAndStop(1);
		}
		private function createMessage(e:MouseEvent):void {
			if(!par.credits){
				par.credits=true;
				par.addFade();
				var msg:Message = new Message(1,true);
				par.addChild(msg);
			}
		}
	}
}