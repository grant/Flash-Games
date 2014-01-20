package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Bird extends MovieClip {
		public var dir:int;
		public var speed:Number=.1;
		public function Bird(py:int,size:Number,d:int):void {
			y = py;
			width = size;
			height = size*1.29;
			dir = d;
			speed*=size;//size/10;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(Event.ENTER_FRAME,moveBird);
		}
		private function onAdd(e:Event):void {
			if(dir===1){
				scaleX*=-1;
				x = 0-width;
			} else {
				x = stage.stageWidth+width;
			}
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function moveBird(e:Event):void {
			x += speed*dir;
			if(x>stage.stageWidth+width){
				if(dir===1){
					remove();
				}
			} else if(x<0-width){
				if(dir===-1){
					remove();
				}
			}
		}
		private function remove():void {
			removeEventListener(Event.ENTER_FRAME,moveBird);
			MovieClip(parent).removeChild(this);
		}
	}
}