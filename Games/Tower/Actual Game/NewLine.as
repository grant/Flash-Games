package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class NewLine extends MovieClip {
		private const alphaSpeed:Number = 0.2;
		private var par:MovieClip;
		public var dir:int;
		private var blockSize:uint;
		private var yDes:uint = 0;
		public function NewLine(d:int,size:uint):void {
			dir = d;
			blockSize = size;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			alpha = 0;
			//yDes = y;
			//y = yDes + blockSize;
			
			
			par = MovieClip(parent);
			
			addEventListener(Event.ENTER_FRAME,onLoop);
			
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onLoop(e:Event):void {
			//y += (yDes-y)*.3;
			if(alpha<1) {
				alpha += alphaSpeed;
			}
			if(dir==1){
				x += par.speed;
			} else {
				x -= par.speed;
			}
			if(x+width>par.endX){
				x = par.endX-width;
				dir=-1;
			} else if(x<par.startX){
				x = par.startX;
				dir=1;
			}
		}
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
			MovieClip(parent).removeChild(this);
		}
	}
}