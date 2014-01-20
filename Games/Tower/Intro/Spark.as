package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Spark extends MovieClip {
		private const sparkLength:uint = 10;
		private var sparkTimer:uint = 0;
		private const fadeSpeed:Number = .1;
		private var rotSpeed:Number = Math.random()*10-5;
		public function Spark(px:uint,py:uint):void {
			x = px;
			y = py;
			alpha = 0;
			addEventListener(Event.ENTER_FRAME,spin);
		}
		private function spin(e:Event):void {
			rotation += rotSpeed;
			if(alpha<1){
				alpha += fadeSpeed;
			} else {
				if(sparkTimer>=sparkLength){
					remove();
				} else {
					sparkTimer++;
				}
			}
		}
		private function remove():void {
			removeEventListener(Event.ENTER_FRAME,spin);
			addEventListener(Event.ENTER_FRAME,fadeOut);
		}
		private function fadeOut(e:Event):void {
			rotation += rotSpeed;
			if(alpha > 0){
				alpha -= fadeSpeed;
			} else {
				removeEventListener(Event.ENTER_FRAME,fadeOut);
				MovieClip(parent).removeChild(this);
			}
		}
	}
}