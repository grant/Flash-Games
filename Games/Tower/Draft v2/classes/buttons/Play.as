/**
 * Play button to start the game
 **/
package buttons{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Play extends MovieClip {
		//constants
		private const EASE:Number=0.05;
		
		//variables
		private var normalSize:uint=width;
		private var bigSize:uint=uint(width*1.05);

		private var par:MovieClip;
		
		private var moving:Boolean = true;

		//Movement
		private var xDes:uint;
		private var yDes:uint;
		private var ys:Number=0;
		private var acc:Number=3;

		public function Play():void {
			x=1000;//off screen
			this.buttonMode = true;
			addEventListener(MouseEvent.CLICK,onClick,false,0,true);
			addEventListener(MouseEvent.ROLL_OVER,rollingOver,false,0,true);
			addEventListener(MouseEvent.ROLL_OUT,rollingOut,false,0,true);
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			par=MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onClick(e:Event):void {
			if(!moving) {//if not moving
				moving = true;
				par.continueIntro();
			}
		}
		private function rollingOver(e:MouseEvent):void {
			//enlarge button
			width=bigSize;
			height=bigSize;
			//add butterflies
			addEventListener(Event.ENTER_FRAME,addButterflies,false,0,true);
		}
		private function rollingOut(e:MouseEvent):void {
			//normal button
			width=normalSize;
			height=normalSize;
			//don't add butterflies
			removeEventListener(Event.ENTER_FRAME,addButterflies);
		}

		//Moving methods
		public function toCenter():void {
			x=550;
			y=250;
			xDes=250;
			yDes=250;
			addEventListener(Event.ENTER_FRAME,moveButton,false,0,true);
		}
		public function toBottom():void {
			x=250;
			y=250;
			addEventListener(Event.ENTER_FRAME,gravity,false,0,true);
		}
		private function moveButton(e:Event):void {
			x += (xDes - x)*EASE;
			y += (yDes - y)*EASE;
			if(Math.abs(x-xDes)<5) {
				moving = false;
				x = xDes;
				y = yDes;
				removeEventListener(Event.ENTER_FRAME,moveButton);
			}
		}
		private function gravity(e:Event):void {
			y+=ys;
			if(ys<10){
				ys+=acc;
			}
		}

		/**
		 * Adds butterflies
		 **/
		private function addButterflies(e:Event):void {
			par.addButterfly(x,y);
		}
	}
}