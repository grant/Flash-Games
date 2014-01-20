package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Square extends MovieClip {
		private const g:Number = 1;
		private const f:Number = .5;
		private var ys:Number=0;
		private var desx:int;
		private var desy:int;
		private var px:int;
		private var par2:MovieClip;
		public function Square(dx:int,dy:int,posx:int,py:int,w:uint,h:uint) {
			desx = dx;
			desy = dy;
			px = posx;
			x = px;
			y = py;
			width = w;
			height = h;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par2 = MovieClip(parent.parent);
			if(desx!==x){
				addEventListener(Event.ENTER_FRAME,moveX);
			}
			if(desy!==y){
				addEventListener(Event.ENTER_FRAME,moveY);
			}
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function moveX(e:Event):void {
			changeX();
		}
		private function moveY(e:Event):void {
			changeY();
		}
		private function changeX():void {
			if(Math.abs(x-desx)<2){
				x = desx;
				removeEventListener(Event.ENTER_FRAME,moveX);
			} else {
				x += (desx-x)*.4;
			}
		}
		private function changeY():void {
			ys+=g;
			y += ys;
			if(y > desy){
				if(ys<1){
					removeEventListener(Event.ENTER_FRAME,moveY);
				} else {
					ys*=-f;
				}
				y = desy;
			}
		}
	}
}