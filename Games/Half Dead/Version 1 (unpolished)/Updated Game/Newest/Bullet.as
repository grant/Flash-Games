package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Bullet extends MovieClip {
		public var mouseXDifference:Number=0;
		public var mouseYDifference:Number=0;
		public var angle:Number=0;
		public var directionX:Number=0;
		public var directionY:Number=0;
		public const speed:Number=100;
		public var timer:Number=100;//3.3 sec
		public var gunX:Number;
		public var gunY:Number;
		public var gunRotation:Number;
		public var charXpos:Number;
		public var charYpos:Number;
		public var par:MovieClip;
		
		public function Bullet(Xpos:Number, Ypos:Number, Rot:Number, charX:Number, charY:Number) {
			gunX=Xpos;
			gunY=Ypos;
			gunRotation=Rot;
			charXpos=charX;
			charYpos=charY;
			addEventListener(Event.ADDED_TO_STAGE,setExternalVars);
		}
		public function setExternalVars(e:Event):void {
			if (parent is MovieClip) {
				par=MovieClip(parent);
			}
			mouseXDifference=stage.mouseX-(gunX+charXpos);
			mouseYDifference=stage.mouseY-(gunY+charYpos);
			angle=Math.atan(mouseYDifference/mouseXDifference)/(Math.PI/180);
			if (mouseXDifference<0) {
				angle+=180;
			}
			if (mouseXDifference>=0&&mouseYDifference<0) {
				angle+=360;
			}
			directionX=Math.cos(angle*Math.PI/180)*speed;
			directionY=Math.sin(angle*Math.PI/180)*speed;
			x = (charXpos+gunX+Math.cos((angle)*Math.PI/180))+(directionX/1.2);//last part deturmined by gun length
			y = (charYpos+gunY+Math.sin((angle)*Math.PI/180))+(directionY/1.2);// ^same^
			rotation=gunRotation;
			addEventListener(Event.ENTER_FRAME,onLoop);
			removeEventListener(Event.ADDED_TO_STAGE,setExternalVars);
		}
		public function onLoop(e:Event):void {
			x+=directionX;
			y+=directionY;
			for (var i = 0; i<par.groundHolder.length; i++) {
				if (par.groundHolder[i].hitTestObject(this)) {//touching ground;
					//par.deadBullets[0]=new Shell(2,par.groundHolder[i].x,y);
					//par.addChild(deadBullets[0]);
					//removeEventListener(Event.ENTER_FRAME,onLoop);
					//parent.removeChild(this);//FIX THIS
				}
			}

			if (timer==0) {
				removeEventListener(Event.ENTER_FRAME,onLoop);
				par.removeChild(this);
			} else {
				timer--;
			}
		}
	}
}