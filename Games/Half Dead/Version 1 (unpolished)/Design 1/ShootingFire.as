package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	public class ShootingFire extends MovieClip {
		private var frame:uint = 1;
		public function ShootingFire(xPos:Number,yPos:Number) {
			x = xPos;
			y = yPos;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onAdd(e:Event):void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
		}
		private function keyIsDown(event:KeyboardEvent):void { //this is so the shooting animation is removed if switching guns.
			switch (event.keyCode) {
				case 69 ://e
				case 81 ://q
					remove();
					break;
			}
		}
		private function onLoop(e:Event):void {
			if(frame!=totalFrames){
				gotoAndStop(frame);
				frame++;
			} else {
				remove();
			}
		}
		private function remove():void {
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			removeEventListener(Event.ENTER_FRAME,onLoop);
			parent.removeChild(this);
		}
	}
}