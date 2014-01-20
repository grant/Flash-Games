/**
 * Controls the rotation of the gear
 **/
package graphic{
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Gear extends MovieClip {
		//constants
		private const ROT_ACC:uint=1;
		private const MAX_SPEED:uint=15;
		private const FRICTION:Number=0.95;
		//variables
		private var rotSpeed:uint=0;
		private var rotating:Boolean=false;
		//MCs
		private var par:MovieClip;
		public function Gear(px:int,py:int):void {
			x = px;
			y = py;
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			par=MovieClip(parent);
			this.mouseEnabled = false;
			width=33;
			height=33;
			addEventListener(Event.ENTER_FRAME,onLoop,false,0,true);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}

		/**
		 * Start the rotation of the gear
		 **/
		public function rotateOn():void {
			rotating=true;
		}

		/**
		 * Stops the rotation of the gear
		 **/
		public function rotateOff():void {
			rotating=false;
		}
		
		/**
		 * Rotates the gear clockwise
		 **/
		private function onLoop(e:Event):void {
			if(rotating) {//if increasing rotational speed
				rotSpeed += ROT_ACC;
			} else {
				rotSpeed *= FRICTION;
			}
			//limits the maximum rotational speed of the gear
			if(rotSpeed>MAX_SPEED) {
				rotSpeed = MAX_SPEED;
			}
			//update the rotation
			rotation += rotSpeed;
		}
	}
}