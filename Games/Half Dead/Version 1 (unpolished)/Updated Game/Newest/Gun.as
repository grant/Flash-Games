//Note:
//ATTACH TO BODY, NOT CHAR

package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;	
	public class Gun extends MovieClip {
		
		// Change shootingRate, startingRecoilRadius, normalRadius, recoilRadiusRate, startingRecoilRotation, recoilRotationRate
		
		private var shooting:Boolean;
		private var recoil:Boolean;
		private var gunYoffset:Number=20;
		private var shootingTimer:uint=0;// const
		
		// shootingRate MUST >= recoilRotationRate
		private const shootingRate:uint=10;// FPS = 30, 1/3 of second
		
		// Radius: The larger the numbder, the closer in
		private const startingRecoilRadius:Number=15;
		private const normalRadius:Number=5;
		
		private var recoilRadius:Number=normalRadius;
		//ABOVE constant, recoil startup value
		
		private var recoilRadiusRate:Number=1.5;// over 1 (error if <1)
		private const startingRecoilRotation:int=40;//Degrees
		private var recoilRotation:Number=0;// const
		
		private var recoilRotationRate:uint=6;
		//ABOVE Smaller = faster; shootingRate MUST >= recoilRotationRate
		
		private var radians:Number;
		private var degrees:Number=0;

		private var pressedE:Boolean=false;
		private var pressedQ:Boolean=false;
		private var switchedGun:Boolean=false;//One time gun switch
		private const xyEase:Number=.5;//0 to 1
		private var changeTimer:uint=0;//const
		private const changeTimerStarting:uint=10; //changeing weapons wait before shooting
		private var final:Number=0;
		private var initial:Number=0;
		private var lastFacingLeft:Boolean=true;
		
		public var gun1:Object = new Object();
		public var gun2:Object = new Object();
		public var gun3:Object = new Object();
		public var gun4:Object = new Object();
		public var gun5:Object = new Object();
		
		public var par2:MovieClip;
		
		public function Gun() {
			stop();
			addEventListener(Event.ADDED_TO_STAGE,setExternalVars);
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		public function setExternalVars(e:Event):void {
			if(parent.parent is MovieClip){
				par2 = MovieClip(parent.parent);
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, checkGun);
			stage.addEventListener(MouseEvent.MOUSE_UP, noShootGun);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
		}
		private function keyIsDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 69 ://e
					if (switchedGun==false) {//actually changing
						recoilRotation=0;
						rotation=270;
						initial=0;
						if (degrees<90) {
							final=degrees+270;
						} else {
							final=degrees-90;
						}
						changeTimer=changeTimerStarting;
						recoilRadius=normalRadius;
						switchedGun=true;
						if (currentFrame!=totalFrames) {
							gotoAndStop(currentFrame+1);
						} else {
							gotoAndStop(1);
						}
					}
					pressedE=true;
					break;
				case 81 ://q
					if (switchedGun==false) {//actually changing
						recoilRotation=0;
						rotation=270;
						initial=0;
						if (degrees<90) {
							final=degrees+270;
						} else {
							final=degrees-90;
						}
						changeTimer=changeTimerStarting;
						recoilRadius=normalRadius;
						switchedGun=true;
						if (currentFrame!=1) {
							gotoAndStop(currentFrame-1);
						} else {
							gotoAndStop(totalFrames);
						}
					}
					pressedQ=true;
					break;
			}
		}

		private function keyIsUp(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 69 ://e
					switchedGun=false;
					pressedE=false;
					break;
				case 81 ://q
					switchedGun=false;
					pressedQ=false;
					break;
			}
		}
		private function checkGun(e:MouseEvent):void {// MOUSE_DOWN
			shooting=true;
		}
		private function onLoop(e:Event):void {
			//Gun Rotation
			radians=Math.atan2(stage.mouseY-(parent.y+y),stage.mouseX-(parent.x+x));
			degrees = Math.round((radians*180/Math.PI))+180;// Change the last number to change overall rotation
			if (parent.x+x>stage.mouseX) {
				scaleY=1;
			} else if (parent.x+x<stage.mouseX) {
				scaleY=-1;
			}
			//Shooting Timer
			if (changeTimer==0) {//not changing weapons
				if (shootingTimer==0) {
					if (shooting==true) {// Everything in here is what actually happens when shooting
					
						par2.bullets[par2.bulletNumber] = new Bullet(x,y,rotation,parent.x,parent.y);
						par2.addChild(par2.bullets[par2.bulletNumber]);
						
						par2.shells[par2.shellNumber] = new Shell(1,parent.x+x,parent.y+y);//frameNumber,x,y
						par2.addChild(par2.shells[par2.shellNumber]);
						
						par2.shootingFires[par2.shootingFireNumber] = new ShootingFire(shootingFirePosition.x,shootingFirePosition.y);
						addChild(par2.shootingFires[par2.shootingFireNumber]);
						
						recoil=true;
						shootingTimer=shootingRate;
					}
				}
			} else {
				changeTimer--;
			}
			if (shootingTimer!=0) {
				shootingTimer--;
			}
			//Recoil Radius
			if (changeTimer==0) {
				if (recoilRadius<=normalRadius) {
					if (recoil==true) {
						recoilRadius=startingRecoilRadius;
						if (parent.x+x>stage.stage.mouseX) {
							recoilRotation=startingRecoilRotation;
						} else if (parent.x+x<stage.stage.mouseX) {
							recoilRotation=- startingRecoilRotation;
						}
						recoil=false;
					}
				} else {
					recoilRadius-=recoilRadiusRate;// goes from starting recoil position to normal position
				}
				if (recoilRotation>0) {
					if (recoilRotation-((recoilRotation/recoilRotationRate) + 1)>0) {//if going to be over 0 (so it doesn't rattle)
						recoilRotation-=(recoilRotation/recoilRotationRate) + 1;// Easing effect + 1 to make the very end faster
					} else {
						recoilRotation=0;
					}
				} else if (recoilRotation<0) {
					if (recoilRotation-((recoilRotation/recoilRotationRate) - 1)<0) {
						recoilRotation-=(recoilRotation/recoilRotationRate) - 1;// Easing effect + 1 to make the very end faster
					} else {
						recoilRotation=0;
					}
				}
			}
			//X and Y values
			//Explanation gun.x = (dis betweeen mouse and gun)/recoilRadius + starting gun position
			//PREVIOUS LINE Explanation, (dis-gun.x)*.5; Easing
			x += (((stage.mouseX-(parent.x+x))/recoilRadius+((parent.x)))-(parent.x+x))*xyEase;
			y += (((stage.mouseY-(parent.y+y))/recoilRadius+((parent.y+gunYoffset)-(60)))-(parent.y+y))*xyEase;
			//Rotation
			//BAD CODE
			//Explanation: gets rid of recoil (subtracts recoilRotation number from previous)
			if (changeTimer==0) {
				rotation-=recoilRotation+recoilRadiusRate;
				rotation=degrees;
				//Adds recoil
				rotation+=recoilRotation;
			} else {
				if (degrees<90) {
					final=degrees+270;
				} else {
					final=degrees-90;
				}
				if (rotation<90) {
					initial=rotation+270;
				} else {
					initial=rotation-90;
				}
				if (changeTimer!=changeTimerStarting-1) {//so first frame is 270 degrees; -1 is because changeTimer--; above
					rotation+=(final-initial)*.5;
				} else {
					rotation=270;
				}
			}
		}
		private function noShootGun(e:MouseEvent):void {// MOUSE_UP
			shooting=false;
		}
	}
}