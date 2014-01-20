package buttons {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Credits extends MovieClip {
		//constants
		private const ease:Number = 0.1;
		private var par:MovieClip;
		
		//variables 
		private var xDes:int;
		private var yDes:int;
		public function Credits():void {
			stop();
			this.buttonMode = true;
			//set off the stage
			this.x = -80;
			this.y = -80;
			addEventListener(MouseEvent.CLICK,createMessage,false,0,true);
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
			addEventListener(MouseEvent.ROLL_OVER,onRollingIn,false,0,true);
			addEventListener(MouseEvent.ROLL_OUT,onRollingOut,false,0,true);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onRollingIn(e:MouseEvent):void {
			gotoAndStop(2);
		}
		private function onRollingOut(e:MouseEvent):void {
			gotoAndStop(1);
		}
		private function createMessage(e:MouseEvent):void {
			par.addMessage("credits");
		}
		
		//Sets the banner on or off the stage
		public function makeVisible():void {
			xDes = 0;
			yDes = 0;
			moveBanner();
		}
		public function makeInvisible():void {
			xDes = -80;
			yDes = -80;
			moveBanner();
		}
		
		private function moveBanner():void {
			addEventListener(Event.ENTER_FRAME,onLoop,false,0,true);
		}
		private function onLoop(e:Event):void {
			//move banner
			x += ((xDes-x)*ease);
			y += ((yDes-y)*ease);
			//check to see if you can remove the enter frame event
			if(Math.abs(x-xDes)<1) {//if 1 pixel from the destination
				//remove the event
				removeEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
	}
}