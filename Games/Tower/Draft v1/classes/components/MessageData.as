/**
 * Message data for the messages
 **/
package components {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class MessageData extends MovieClip {
		//constants
		private const FADE_IN_SPEED:Number = .1;
		private const FADE_OUT_SPEED:Number = .25;
		private var par:MovieClip;
		public function MessageData():void {
			stop();
			alpha = 0;
			x = -170;
			y = -140;
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		/**
		 * Shows or removes the message data
		 **/
		public function showData():void {
			addEventListener(Event.ENTER_FRAME,fadeIn);
		}
		public function removeData():void {
			addEventListener(Event.ENTER_FRAME,fadeOut);
		}
		
		/**
		 * Fades in or out
		 **/
		private function fadeIn(e:Event):void {
			if(alpha<1){//not fully transparent
				alpha += FADE_IN_SPEED;
			} else {//fully transparent
				removeEventListener(Event.ENTER_FRAME,fadeIn);
			}
		}
		private function fadeOut(e:Event):void {
			if(alpha>0){//a bit transparent
				alpha -= FADE_OUT_SPEED;
			} else {//transluscent
				removeEventListener(Event.ENTER_FRAME,fadeOut);
				//par.removeChild(this);//causes a glitch, and it doesn't matter because the parent is removed
			}
		}
		
		/**
		 * Sets the data
		 **/
		public function goto(messageName:String):void {
			switch(messageName) {
				case "credits":
					gotoAndStop(1);
					break;
			}
		}
	}
}