//scaleX code on Body.as
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Eyebrow extends MovieClip {
		private var par:MovieClip;
		private var xDes:Number;
		private var yDes:Number;
		public function Eyebrow(frameNumber:uint,xPos:int,yPos:int) {
			gotoAndStop(frameNumber);
			stop();
			xDes=xPos;
			yDes=yPos;
			addEventListener(Event.ADDED_TO_STAGE,setExternalVars);
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		public function setExternalVars(e:Event):void {
			if (parent is MovieClip) {//check parents only
				par=MovieClip(parent);//par = parent
				//trace(par.foot1.y); example
			}
		}
		public function onLoop(e:Event):void {
			y = par.body.y+yDes;
			if(scaleX==1){
				x = par.body.x+xDes;
			} else {
				x = par.body.x-xDes;
			}
		}
	}
}