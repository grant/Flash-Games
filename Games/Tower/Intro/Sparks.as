package {
	import flash.display.Sprite;
	import flash.events.Event;
	public class Sparks extends Sprite {
		private const gravity:Number=.3;
		private var xs:Number=Math.random()*10-5;
		private var ys:Number=Math.random()*10-5;
		private var a:Number=Math.random()*.5+.4;
		private var size:uint=Math.ceil(Math.random()*20);
		public function Sparks(xpos:uint,ypos:uint):void {
			mouseEnabled=false;
			x=xpos;
			y=ypos;
			width=size;
			height=size;
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			x+=xs;
			ys+=gravity;
			y+=ys;
			if (y-(size*.5)>=stage.stageHeight) {
				remove();
			} else {
				a-=.01;
				if (a<=0) {
					remove();
				} else {
					alpha=a;
				}
			}
		}
		private function remove():void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
			parent.removeChild(this);
		}
	}
}