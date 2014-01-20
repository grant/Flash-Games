package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Butterfly extends MovieClip {
		private const rotSpeed:uint = 5;
		private const speed:Number = 5;
		private var dir:int=Math.random();
		private var size:uint = Math.random()*10+20;
		private var chance:Number = .1;
		private var dice:Number = 1;
		public function Butterfly(px:int,py:int):void {
			x = px;
			y = py;
			width = size;
			height = size;
			rotation = Math.random()*360-180;
			
			dir = (dir<.5)?-1:1;
			
			addEventListener(Event.ENTER_FRAME,direct);
			addEventListener(Event.ENTER_FRAME,moveFly);
		}
		private function direct(e:Event):void {
			if(dice<=chance){
				dice = 1;
				dir = (dir==1)?-1:1;
			} else {
				dice -= Math.random()*.1;
				rotation += dir*rotSpeed;
			}
			if(x+width<0||x-width>stage.stageWidth||y+height<0||y>stage.stageHeight+height){
				removeEventListener(Event.ENTER_FRAME,direct);
				removeEventListener(Event.ENTER_FRAME,moveFly);
				par.removeChild(this);
			}
		}
		private function moveFly(e:Event):void {
			if (rotation>180) {
				y += (speed*Math.cos(Math.PI/180*rotation));
				x -= (speed*Math.sin(Math.PI/180*rotation));
			} else {
				y -= (speed*Math.cos(Math.PI/180*rotation));
				x += (speed*Math.sin(Math.PI/180*rotation));
			}
		}
	}
}