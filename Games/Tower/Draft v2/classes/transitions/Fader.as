/**
 * Fades the screen from black to transparent, the other way around, and with white
 * Can also go to partial transparencies
 **/
package transitions {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Fader extends MovieClip {
		//constants
		private var BLACK_TRANSPARENT:uint = 1;
		private var BLACK:uint = 25;
		
		private var WHITE_TRANSPARENT:uint = 26;
		private var WHITE:uint = 50;
		
		//varibles
		private var dir:String;//direction
		private var done:Boolean = true;
		
		private var startFrame:uint;
		private var endFrame:uint;
		public function Fader():void {
			stop();
			this.mouseEnabled = false;//buttons underneath can be clicked
		}
		
		/**
		 * Transitions to black
		 * @param transparency alpha from 0 to 100
		 **/
		public function toBlack(transparency:uint=100):void {
			startFrame = BLACK_TRANSPARENT;
			endFrame = BLACK;
			dir = "forwards";//direction
			startTransition();
		}
		
		/**
		 * Transition to white
		 * @param transparency alpha from 0 to 100
		 **/
		public function toWhite(transparency:uint=100):void {
			startFrame = WHITE_TRANSPARENT;
			endFrame = WHITE;
			dir = "forwards";//direction
			startTransition();
		}
		
		/**
		 * Transition from black to transparent
		 **/
		public function blackToTransparent():void {
			startFrame = BLACK;
			endFrame = BLACK_TRANSPARENT;
			dir = "backwards";//direction
			startTransition();
		}
		
		/**
		 * Transition from white to transparent
		 **/
		public function whiteToTransparent():void {
			startFrame = WHITE;
			endFrame = WHITE_TRANSPARENT;
			dir = "backwards";//direction
			startTransition();
		}
		
		/**
		 * Transitions to transparent
		 **/
		public function toTransparent():void {
			if(this.currentFrame<=BLACK) {//if the transitionn is on black
				startFrame = this.currentFrame;
				endFrame = BLACK_TRANSPARENT;
			} else {//if the transition is on white
				startFrame = this.currentFrame;
				endFrame = WHITE_TRANSPARENT;
			}
			dir = "backwards";//direction
			startTransition();
		}
		
		/**
		 * Starts the transition
		 **/
		private function startTransition():void {
			done = false;
			this.mouseEnabled = true;//buttons underneath can't be clicked
			gotoAndStop(startFrame);
			if(!hasEventListener(Event.ENTER_FRAME)) {
				addEventListener(Event.ENTER_FRAME,onLoop,false,0,true);
			}
		}
		
		/**
		 * Move frames
		 **/
		public function onLoop(e:Event):void {
			if(currentFrame!=endFrame) {//if not done
				if(dir=="forwards") {
					gotoAndStop(currentFrame+1);
				} else {
					gotoAndStop(this.currentFrame-1);
				}
			} else {
				done = true;
				if(currentFrame==BLACK_TRANSPARENT||currentFrame==WHITE_TRANSPARENT) {//if the fader is currently transparent
					this.mouseEnabled = false;//buttons underneath can be clicked
				}
				removeEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
		
		/**
		 * Sets the visibility of the fader
		 **/
		public function setVisible(isVisible:Boolean):void {
			this.visible = isVisible;
		}
	}
}