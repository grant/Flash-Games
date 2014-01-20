package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Shell extends MovieClip {

		private var widthStart:Number=18;//25
		private var heightStart:Number=7.5;//10
		private var xs:Number=Math.random()*15-7.5;//-7.5 to 7.5
		private var ys:Number=Math.random()*5-7;
		private const maxYs:uint=30;
		private var previousX:Number = x;
		private var previousY:Number = y;
		private var rotationSpeed:Number=Math.random()*10+5;
		private const gravity:Number=.8;
		private const friction:Number=.85;
		private const groundFriction:Number=.1;
		//private const randomGround:Number=Math.random()*10-5;
		private const fallRotationSpeed:Number=11
		;//lower = faster
		private var alteredRotation:Number=0;
		private var hittingGround:Boolean = false;
		private var hittingGroundUp:Boolean = false;
		private var hittingGroundDown:Boolean = false;
		private var timer:uint=100;//3.3 sec
		private var par:MovieClip;
		
		private var alteredRot:Number;
		private var radian1:Number;
		private var widthTrig:Number;
		private var radian2:Number;
		private var heightTrig:Number;	
		public function Shell(frame:uint,xPos:Number,yPos:Number) {
			x = xPos;
			y = yPos;
			gotoAndStop(frame);
			if(frame==1){
				widthStart = 18;
				heightStart = 7.5;
			} else if(frame==2){
				widthStart = 19;
				heightStart = 8;
			}
			width=widthStart;
			height=heightStart;
			rotation=Math.random()*360;
			addEventListener(Event.ADDED_TO_STAGE,setExternalVars);
			addEventListener(Event.ENTER_FRAME,moveShell);
		}
		public function setExternalVars(e:Event):void {
			if (parent is MovieClip) {//check parents only
				par=MovieClip(parent);//par = parent
				//trace(par.foot1.y); example
			}
			removeEventListener(Event.ADDED_TO_STAGE,setExternalVars);
		}
		public function moveShell(e:Event):void {
			changePosition();
			collisionDetection();
			endRotation();
			previousPos();
			checkDeletion();
		}
		public function changePosition():void {
			x+=xs;
			if (ys>=maxYs) {
				ys=maxYs;
			} else {
				ys+=gravity;
			}
			y+=ys;
			
		}
		public function collisionDetection():void {
			hittingGround = false;
			hittingGroundUp = false;
			hittingGroundDown = false;
			for (var i = 0; i<par.groundHolder.length; i++) {
				if (par.groundHolder[i].hitTestPoint(x,y+(height/2))) {//touching ground
					hittingGround = true;
					if(previousX<par.groundHolder[i].x){
						xs = -xs/2;
						x += 2*xs;//so not stuck in wall
					} else if(previousX>par.groundHolder[i].x+par.groundHolder[i].width){
						xs = -xs/2;
						x += 2*xs;//so not stuck in wall
					} else if(previousY<=par.groundHolder[i].y){
						hittingGroundUp = true;
						
						alteredRot = rotation+180;
						radian1 = 0.0174532925*Math.abs(rotation);
						widthTrig = (Math.sin(radian1)*(widthStart/2));
						radian2 = 0.0174532925*(90-(Math.abs(rotation)));
						heightTrig = (Math.sin(radian2)*(heightStart/2));
						if(alteredRot<90){
							y = par.groundHolder[i].y-widthTrig+heightTrig+2;
						} else if(alteredRot<180){
							y = par.groundHolder[i].y-widthTrig-heightTrig+2;
						} else if(alteredRot<270){
							y = par.groundHolder[i].y-widthTrig-heightTrig+2;
						} else {
							y = par.groundHolder[i].y-widthTrig+heightTrig+2;
						}
						if(ys<1){
							ys = 0;
						} else {
							ys=- ys/2;
						}
						xs*=friction;
					} else if(previousY>par.groundHolder[i].y+par.groundHolder[i].height){
						hittingGroundDown = true;
						y=par.groundHolder[i].y;
						ys = gravity;
						xs*=friction;
					}
				}
			}
		}
		public function endRotation():void {
			alteredRotation=rotation+180;//because rotation is normally -180 to 180
			if((hittingGroundUp==true||hittingGroundDown==true)&&ys>=0&&ys<3){
				xs*groundFriction;
				if (alteredRotation<270&&alteredRotation>180) {
					rotationSpeed=Math.abs(alteredRotation-270);
					//180 = fast and destination
					//270 = slow
					if (alteredRotation-(rotationSpeed/fallRotationSpeed)>180) {
						rotation-=rotationSpeed/fallRotationSpeed;
					} else {
						rotation=0;
					}
				} else if (alteredRotation>270) {
					rotationSpeed=(alteredRotation-270);
					//270 = slow
					//360 = fast and des
					if (alteredRotation+(rotationSpeed/fallRotationSpeed)>359) {
						rotation=180;
					} else {
						rotation+=rotationSpeed/fallRotationSpeed;
					}
				} else if (alteredRotation<90) {
					rotationSpeed=Math.abs(alteredRotation-90);
					//90 = slow
					//0 = fast
					if (alteredRotation-(rotationSpeed/fallRotationSpeed)<0) {
						rotation=180;
					} else {
						rotation-=rotationSpeed/fallRotationSpeed;
					}
				} else if (alteredRotation>90&&alteredRotation<180) {
					rotationSpeed=Math.abs(alteredRotation-90);
					//90 = slow
					//180 = fast
					if (alteredRotation+(rotationSpeed/fallRotationSpeed)>180) {
						rotation=0;
					} else {
						rotation+=rotationSpeed/fallRotationSpeed;
					}
				}
			} else {
				if(ys==gravity){//to fix glitch when shell falls off of right edge
					rotationSpeed = 2;
				}
				rotation += rotationSpeed;
			}
		}
		public function previousPos():void {
			previousX = x;
			previousY = y;
		}
		public function checkDeletion():void {
			if (timer==0) {
				if (alpha>0) {
					alpha-=.01;
				} else {
					removeEventListener(Event.ENTER_FRAME,moveShell);
					parent.removeChild(this);
				}
			} else {
				timer--;
			}
		}
	}
}