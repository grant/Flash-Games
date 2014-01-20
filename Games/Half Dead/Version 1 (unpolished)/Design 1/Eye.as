//scaleX code on Body.as
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Eye extends MovieClip {
		private var par:MovieClip;
		private var xDes:Number;
		private var yDes:Number;
		private var frame:uint;
		private var closeLid:Boolean;
		private const closeSpeed:uint = 1;
		private const blinkTimerLength:uint = 200;
		private var blinkTimer:uint = blinkTimerLength;
		public function Eye(frameNumber:uint,xPos:int,yPos:int) {
			frame = frameNumber;
			gotoAndStop(frame);
			xDes=xPos;
			yDes=yPos;
			addEventListener(Event.ADDED_TO_STAGE,setExternalVars);
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function setExternalVars(e:Event):void {
			if (parent is MovieClip) {//check parents only
				par=MovieClip(parent);//par = parent
				//trace(par.foot1.y); example
			}
		}
		private function onLoop(e:Event):void {
			y = par.body.y+yDes;
			if(scaleX==1){
				x = par.body.x+xDes;
			} else {
				x = par.body.x-xDes;
			}
			
			if(blinkTimer<=0){
				closeLid = true;
				blinkTimer=blinkTimerLength;
			} else {
				blinkTimer--;
			}
			if(closeLid){
				if(frame+closeSpeed<=totalFrames){
					frame+=closeSpeed;
					gotoAndStop(frame);
				} else {
					closeLid=false;
				}
			}
			if(closeLid==false){
				if(frame>1){
					frame-=closeSpeed;
					gotoAndStop(frame);
				} else {
					frame = 1;
				}
			}
		}
	}
}