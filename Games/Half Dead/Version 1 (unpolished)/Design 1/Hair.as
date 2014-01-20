//scaleX code on Body.as
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Hair extends MovieClip {
		private var par:MovieClip;
		public function Hair(frameNumber:uint) {
			gotoAndStop(frameNumber);
			stop();
		
			x=0;
			y=0;
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
			x = par.body.x;
			y = par.body.y;
		}
	}
}