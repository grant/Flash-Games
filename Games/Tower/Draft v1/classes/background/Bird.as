/**
 * Flying bird in the background
 **/
package background {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Bird extends MovieClip {
		private var removed:Boolean = false;
		private var dir:int;
		private var speed:Number=.1;
		private var limit:Number;//limit of x position until bird is removed
		public function Bird(py:int = 0,size:Number = 100,dir:int = 10):void {
			y = py;
			width = size;
			height = size*1.29;
			this.dir = dir;
			speed*=size;
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			if(dir===1){
				scaleX*=-1;
				x = 0-width;
				limit = stage.stageWidth+width;
			} else {
				x = stage.stageWidth+width;
				limit = 0-width;
			}
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		public function moveBird():void {
			x += speed*dir;
			if(!removed) {
				if(dir===1&&x>limit){
					remove();
				} else if(dir===-1&&x<limit){
					remove();
				}
			}
		}
		private function remove():void {
			removed = true;
			MovieClip(parent).removeChild(this);
		}
	}
}