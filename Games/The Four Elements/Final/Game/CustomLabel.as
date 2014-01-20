//par:Page
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class CustomLabel extends MovieClip {
		private const fadeAmount:Number = 0.04;//the amount the label fades per frame;
		private var disappearTime:uint = 20;//how many frames since the label is fully shown that it dissapears again
		private var timeToDisappear:uint=0;//frames until the dissapearing begins
		private var visibility:Number = 0;//how apparent the label is (alpha)
		private var appearing:Boolean = true;//if appearing or disappearing
		private var id:uint;//the id for the label (frame number)
		
		//parent
		private var par:MovieClip;
		public function CustomLabel(labelId:uint,toAppear:Boolean):void {
			id = labelId;
			gotoAndStop(id);
			appearing = toAppear;
			if(toAppear) {
				visibility = 0;
			} else {
				visibility = 1;
			}
			mouseEnabled = false;
			addEventListener(Event.ENTER_FRAME,onLoop);
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//sets the visibility of the label
		private function setVisibility(amount:Number):void {
			this.alpha = amount;
		}
		
		//gets the visibility of teh label
		public function getVisibility():Number {
			return visibility;
		}
		
		//makes the label disappear after an x number of frames
		public function disappear(frames:uint=0):void {
			timeToDisappear = frames;
		}
		
		//makes the label appear
		public function appear():void {
			appearing = true;
			if(!this.hasEventListener(Event.ENTER_FRAME)) {
				addEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
		
		//makes the label disappear or appear or wait to do one of them
		private function onLoop(e:Event):void {
			if(appearing) {
				if(visibility>=1) {
					appearing = false;
					visibility = 1;
					disappear(disappearTime);
				} else {
					visibility += fadeAmount;
				}
			} else {//waiting or disappearing
				if(timeToDisappear==0) {//disappearing
					if(visibility>0) {
						visibility -= fadeAmount;
					} else {
						visibility = 0;
						removeEventListener(Event.ENTER_FRAME,onLoop);
					}
				} else {
					timeToDisappear--;
				}
			}
			setVisibility(visibility);
		}
		
		//instantly disappears the label
		public function setDisappear():void {
			setVisibility(0);
			appearing = false;
		}
		
		//removes the label
		public function remove():void {
			par.removeChild(this);
		}
		
		//set disappear time
		public function setDisappearTime(time:uint):void {
			disappearTime = time;
		}
	}
}