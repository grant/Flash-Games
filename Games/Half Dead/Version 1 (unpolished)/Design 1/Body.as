package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Body extends MovieClip {

		public const bodyOffset:int=-30;
		private const bodyEase:Number=1;
		private var breathingAcceleration:Number=0;
		private var breathingRate:Number=1;
		private const breathingStrength:Number=.5;
		
		private var par:MovieClip;
		private var par2:MovieClip;

		public function Body() {
			stop();
			addEventListener(Event.ADDED_TO_STAGE,setExternalVars);
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		public function setExternalVars(e:Event):void {
			if (parent is MovieClip) {//check parents only
				par=MovieClip(parent);//par = parent
				//trace(par.foot1.y); example
			}
			if (parent.parent is MovieClip) {
				par2=MovieClip(parent.parent);
			}
		}
		public function onLoop(e:Event):void {
			//y += ((bodyOffset+((par.foot1.y+par.foot2.y)/2))-y)/(10/bodyEase);//FIX RIGHT HERE
			y += (bodyOffset-y)/10;
			y += (par.speedY/10)
			breathingAcceleration+=breathingRate/10;
			y += (Math.sin(breathingAcceleration)*breathingStrength);
			if (par.x>stage.mouseX) {//mouse right
				if (par.lastFacingLeft==true) {
					par.lastFacingLeft=false;
					par.hair.scaleX=-1;
					par.nose.scaleX=-1;
					par.eye1.scaleX=-1;
					par.eye2.scaleX=-1;
					par.eyebrow1.scaleX=-1;
					par.eyebrow2.scaleX=-1;
					par.foot1.scaleX=-1;
					par.foot2.scaleX=-1;
				}
			}
			if (par.x<stage.mouseX) {//mouse left
				if (par.lastFacingLeft==false) {
					par.lastFacingLeft=true;
					par.hair.scaleX=1;
					par.nose.scaleX=1;
					par.eye1.scaleX=1;
					par.eye2.scaleX=1;
					par.eyebrow1.scaleX=1;
					par.eyebrow2.scaleX=1;
					par.foot1.scaleX=1;
					par.foot2.scaleX=1;
				}
			}
			for (var i = 0; i<par2.groundHolder.length; i++) {
				if (par2.groundHolder[i].hitTestPoint(par.x+x,par.y+50)&&par.speedY > 0) {//if about to hit ground
					par.foot1.rotation/=1.5;
					par.foot2.rotation/=1.5;
				}
				if (par2.groundHolder[i].hitTestPoint(par.x+x,par.y+y-height)) {//top of body touching ground
					if(par.speedY<0){
						par.speedY=par.gravity;
						par.y += 1;//stop glitching
					}
				}
			}
		}
	}
}