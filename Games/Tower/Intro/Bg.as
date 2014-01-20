package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Bg extends MovieClip {
		private const birdRate:uint = 100;
		private var birdTimer:uint = 0;
		public function Bg():void {
			addEventListener(Event.ENTER_FRAME,addBirds);
		}
		private function addBirds(e:Event):void {
			if(birdTimer===birdRate){
				birdTimer=0;
				var py:int = (Math.random()*stage.stageHeight*(2/3))+20;
				var size:Number = Math.random()*10+5;
				var dir:int = Math.round(Math.random());
				if(dir===0){
					dir = -1;
				}
				var bird:Bird = new Bird(py,size,dir);
				addChild(bird);
			} else {
				birdTimer++;
			}
		}
	}
}