package {
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class Character extends MovieClip {
		//http://help.adobe.com/en_US/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7f8a.html
		public var radius:Number=50;
		public var angle:Number=90;
		public var speed:Number=15;
		public const charstartx:Number=200;
		public const charstarty:Number=400;
		public const startx1:Number=0;
		public const starty1:Number=-10;
		public const startx2:Number=0;
		public const starty2:Number=0;
		public var pressedA:Boolean=false;
		public var pressedD:Boolean=false;
		public var moveLeft:int=1;//left = -1, stop = 0, right = 1
		public var lastKeyPress:String;//A or D
		public var lastMove:Number=radius/strideWidth;
		public var strideWidth:Number=1.5;//Larger = smaller stride; Smaller = larger stride
		public var breathing:Number=0;
		public const breathingrate:Number=1;

		//Jumping
		public var pressedW:Boolean=false;
		public var speedY:Number=0;
		public var speedX:Number=0;
		public const accelerationX:Number=1;
		public const gravity:Number=1.5;
		public const friction:Number=.95; //x axis only
		public const maxspeedX:Number=7; //jumping and moving on x axis
		public var jumping:Boolean=false;
		public const jumpingStrengthStart:Number=18;
		public var jumpingStrength:Number=jumpingStrengthStart;
		public var ground:Number=300;
		public var jumpfoot1x:Number=30;
		public var jumpfoot1y:Number=-10;
		public var jumpfoot2x:Number=-30;
		public var jumpfoot2y:Number=-10;
		public var jumpfootease:Number=5;//larger = longer
		public const jumpfootrotationstart:Number=30;
		public var jumpfootrotation:Number=jumpfootrotationstart;
		public var doublejumping:Boolean=false;
		public var letgoW:Boolean=false;//so double jump has to wait until w is let go and pressed again
		public var jump1ok:Boolean=false;//single jump
		public var jump2ok:Boolean=false;//single double jump

		/////////////////////////////GUN//////////////////////////////////////////////

		// Change shootingRate, startingRecoilRadius, normalRadius, recoilRadiusRate, startingRecoilRotation, recoilRotationRate
		public var shooting:Boolean;
		public var recoil:Boolean;
		public var gunYoffset:Number=20;
		public var shootingTimer:uint=0;// const
		// shootingRate MUST >= recoilRotationRate
		public const shootingRate:uint=10;// FPS = 30, 1/3 of second
		// Radius: The larger the number, the closer in
		public const startingRecoilRadius:Number=15;
		public const normalRadius:Number=7;
		public var recoilRadius:Number=normalRadius;// const; recoil startup value
		public var recoilRadiusRate:Number=1.5;// over 1 (error if <1)
		///////////////////////////////////////////
		public const startingRecoilRotation:int=40;//Degrees
		public var recoilRotation:Number=0;// const
		public var recoilRotationRate:uint=6;//Smaller = faster; shootingRate MUST >= recoilRotationRate
		public var radians:Number;
		public var degrees:Number=0;
		///////////////////////////////////////////
		public var pressedE:Boolean=false;
		public var pressedQ:Boolean=false;
		public var switchedGun:Boolean=false;//One time gun switch
		public const xyEase:Number=.5;//0 to 1
		public var changeTimer:uint=0;//const
		public const changeTimerStarting:uint=10; //changeing weapons wait before shooting
		public var final:Number=0;
		public var initial:Number=0;
		public var lastFacingLeft:Boolean=true;

		//////////////////////////////////////////////
		public function Character() {
			stage.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		public function init(e:Event):void {
			stage.addEventListener(Event.ENTER_FRAME, onLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, checkGun);
			stage.addEventListener(MouseEvent.MOUSE_UP, noShootGun);
		}
		public function keyIsDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 65 ://a
					pressedA=true;
					break;
				case 67 ://e
					pressedE=true;
					break;
				case 68 ://d
					pressedD=true;
					break;
				case 81 ://q
					pressedQ=true;
					if (switchedGun==false) {//actually changing
						recoilRotation=0;
						gun.rotation=270;
						initial=0;
						if (degrees<90) {
							final=degrees+270;
						} else {
							final=degrees-90;
						}
						changeTimer=changeTimerStarting;
						recoilRadius=normalRadius;
						switchedGun=true;
						if (gun.currentFrame!=1) {
							gun.gotoAndStop(gun.currentFrame-1);
						} else {
							gun.gotoAndStop(gun.totalFrames);
						}
					}
					break;
				case 87 ://w
					pressedW=true;
					break;
			}
		}
		public function keyIsUp(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 65 ://a
					pressedA=false;
					lastKeyPress="A";
					break;
				case 68 ://d
					pressedD=false;
					lastKeyPress="D";
					break;
				case 87 ://w
					pressedW=false;
					break;
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
		public function checkGun(e:MouseEvent):void {// MOUSE_DOWN
			shooting=true;
		}
		function onLoop(event:Event):void {
			if(jumping==true&&pressedW==false){
				letgoW=true;
			}
			if(y>=ground&&pressedW==false){ //so resets jumping (jump only once)
				jump1ok=true;
				jump2ok=true;
			}
			//Jumping and y
			if (pressedW==true) {
				if (jumping==false) { //Jumping initializer Everything that happens once is here
					if(jump1ok==true){
						jump1ok=false;
					if(angle>=0&&angle<180){
						angle = 90;
					} else {
						angle = 270;
					}
					//foot1.rotation=0;
					//foot2.rotation=0;
					jumping=true;
					speedY=-jumpingStrength;
					}
				}
				if(jumping==true){
					if(letgoW==true){
						if(doublejumping==false){
							if(jump2ok==true){
								jump2ok=false;
							doublejumping=true;
							speedY=-jumpingStrength;
							//optional
							foot1.rotation=0;
							foot2.rotation=0;
							}
						}
					}
				}
			}
	
			if (pressedA==true) {
				moveLeft=-1;
			} else if (pressedD==true) {
				moveLeft=1;
			} else {
				moveLeft=0;
			}

			if(jumping==true){
				if(pressedA==true){
					if(speedX>=-maxspeedX){
						speedX-=accelerationX;
					}
				} else if(pressedD==true){
					if(speedX<=maxspeedX){
						speedX+=accelerationX;
					}
				}
				speedX*=friction;
				x+=speedX;
				
				if(x>stage.stage.mouseX){//mouse left
					jumpfootrotation= -jumpfootrotationstart;
					if(lastFacingLeft==true){
						foot1.rotation = -Math.abs(foot1.rotation);
						foot2.rotation = -Math.abs(foot2.rotation);
					}
				} else if(x<stage.stage.mouseX){//mouse right
					jumpfootrotation= jumpfootrotationstart;
					if(lastFacingLeft==false){
						foot1.rotation = Math.abs(foot1.rotation);
						foot2.rotation = Math.abs(foot2.rotation);
					}
				}
				//0-180 foot1 is on right, other on left
				if(angle>=0&&angle<180){ // makes sure that feet are separated and positioned according to where they were when jumped
					foot1.x += (jumpfoot1x-foot1.x)/jumpfootease;
					foot1.y += ((jumpfoot1y+starty1)-foot1.y)/jumpfootease;
					foot1.rotation += (jumpfootrotation-foot1.rotation)/jumpfootease;
					foot2.x += (jumpfoot2x-foot2.x)/jumpfootease;
					foot2.y += (jumpfoot2y-foot2.y)/jumpfootease;
					foot2.rotation += (jumpfootrotation-foot2.rotation)/jumpfootease;
				} else {
					foot1.x += (jumpfoot2x-foot1.x)/jumpfootease;
					foot1.y += ((jumpfoot1y+starty1)-foot1.y)/jumpfootease;
					foot1.rotation += (jumpfootrotation-foot1.rotation)/jumpfootease;
					foot2.x += (jumpfoot1x-foot2.x)/jumpfootease;
					foot2.y += (jumpfoot2y-foot2.y)/jumpfootease;
					foot2.rotation += (jumpfootrotation-foot2.rotation)/jumpfootease;
				}
			} else {
				if(pressedA==true){
					speedX=-speed/3;
				} else if(pressedD==true){
					speedX=speed/3;
				} else {
					speedX=0;
				}
			}
			
			if (y<ground) {
				speedY+=gravity;
			} else if(y>ground){
				jumping=false;
				doublejumping=false;
				letgoW=false;
				y=ground;
				speedY=0;
			}
			y+=speedY;
			if(jumping==false){
				if (moveLeft==1) {
					angle+=speed;
				} else if (moveLeft==-1) {
					angle-=speed;
				}
				if (moveLeft==0) {// if no keys pressed
					if (lastKeyPress=="A") {
						//foot1
						if (angle<=45||angle>270) {
							angle-=speed;
						} else if (angle>45&&angle<90) {
							angle+=speed;
						}
						//foot2
						if (angle>90&&angle<=215) {
							angle-=speed;
						} else if (angle<270&&angle>215) {
							angle+=speed;
						}
					} else if (lastKeyPress=="D") {
						//foot1
						if (angle<315&&angle>270) {
							angle-=speed;
						} else if (angle>=315||angle<90) {
							angle+=speed;
						}
						//foot2
						if (angle>90&&angle<=135) {
							angle-=speed;
						} else if (angle>135&&angle<270) {
							angle+=speed;
						}
					}
				}
			}
			//make sure angle is between 0 and 360
			if (angle<0) {
				angle+=360;
			} else if (angle>=360) {
				angle-=360;
			}
	
			//x based on lastx - shouldbex added to current x
			if(jumping==false){
				if(angle<90||angle>270){
					x-=lastMove-((radius*Math.cos((angle-90)*Math.PI/180))/strideWidth);
				} else if(angle>90&&angle<270){
					x+=lastMove-((radius*Math.cos((angle-90)*Math.PI/180))/strideWidth);
				}
			}
		
			//feet
			if(jumping==false){
				foot1.x = startx1+(radius*Math.cos((angle-90)*Math.PI/180))/strideWidth;
				foot2.x = startx2+(radius*Math.cos((angle+90)*Math.PI/180))/strideWidth;
			}
			//breathing
			//body.y += ((offset(average between feet y)- body.y)/easing;
			body.y += ((-10+((foot1.y+foot2.y)/2))-body.y)/10;
			breathing+=breathingrate/10;
			body.y += (Math.sin(breathing)*.5);
			body.x=0;
			//character direction
			if(x>stage.mouseX){//mouse right
				if(lastFacingLeft==true){
					lastFacingLeft=false;
					body.scaleX=-1;
					foot1.scaleX=-1;
					foot2.scaleX=-1;
				}
			} else if(x<stage.mouseX){//mouse left
				if(lastFacingLeft==false){
					lastFacingLeft=true;
					body.scaleX=1;
					foot1.scaleX=1;
					foot2.scaleX=1;
				}
			}

			lastMove=(radius*Math.cos((angle-90)*Math.PI/180))/strideWidth;//Keep at end!
	
			//Raising foot1
			if(jumping==false){
				if (angle>=270||angle<=90) {
					foot1.y=starty1+(radius*-Math.cos(angle*Math.PI/180));
				} else {
					foot1.y=starty1;
				}
				//Raising foot2
				if (angle<=270&&angle>=90) {
					foot2.y=starty2+(radius*Math.cos(angle*Math.PI/180));
				} else {
					foot2.y=starty2;
				}
	
				//Rotations
				//foot1
				if (angle>=270&&angle<315) {
					//angle 270 to 315
					//rot 0 to 45
					foot1.rotation=angle-270;
				} else if (angle>=315&&angle<360) {
					//angle 315 to 360
					//rot 45 to 0
					foot1.rotation = 90-(angle-270);
				} else if (angle>=0&&angle<45) {
					//angle 0 to 45
					//rot 0 to -45
					foot1.rotation=- angle;
				} else if (angle>=45&&angle<=90) {
					//angle 45 to 90
					//rot -45 to 0
					foot1.rotation=angle-90;
				} else {
					foot1.rotation=0;
				}
	
				//foot2
				if (angle>=90&&angle<135) {
					//angle 90 to 135
					//rot 0 to 45
					foot2.rotation=angle-90;
				} else if (angle>=135&&angle<180) {
					//angle 135 to 180
					//rot 45 to 0
					foot2.rotation = 90-(angle-90);
				} else if (angle>=180&&angle<225) {
					//angle 180 to 215
					//rot 0 to -45
					foot2.rotation= -(angle-180);
				} else if (angle>=215&&angle<=270) {
					//angle 215 to 270
					//rot -45 to 0
					foot2.rotation=angle-270;
				} else {
					foot2.rotation=0;
				}
			}
	
			if(y+(speedY*2)>=ground&&jumping==true){ //KEEP AT END, checks if going to be touching ground soon and makes feet more flat
				foot1.rotation/=2;
				foot2.rotation/=2;
			}
			//Gun
	
			////////////////////////////Gun Rotation////////////////////////////////
	
			radians=Math.atan2(stage.mouseY-(y+gun.y),stage.mouseX-(x+gun.x));
			degrees = Math.round((radians*180/Math.PI))+180;// Change the last number to change overall rotation
			if(x+gun.x>stage.stage.mouseX){
				gun.scaleY=1;
			} else if(x+gun.x<stage.stage.mouseX){
				gun.scaleY=-1;
			}
	
			///////////////////////////ShootingTimer///////////////////////////////	
			if (changeTimer==0) {
				if (shootingTimer==0) {
					if (shooting==true) {// Everything in here is what actually happens when shooting
					
						//var newBullet:bulletClass = new bulletClass();
						// CHANGE THE X AND Y VALUES
						//newBullet.x = x+gun.x;
						//newBullet.y = y+gun.y;
						//this.addChild(newBullet);
				
						//var newShell:shellClass = new shellClass();
						//newShell.x = x+gun.x;
						//newShell.y = y+gun.y;
						//this.addChild(newShell);
				
						recoil=true;
						shootingTimer=shootingRate;
					}
				}
			} else {
				changeTimer--;
			}
			if(shootingTimer!=0){
				shootingTimer--;
			}
			//////////////////////Recoil Radius////////////////////////
			if (changeTimer==0) {
				if (recoilRadius<=normalRadius) {
					if (recoil==true) {
						recoilRadius=startingRecoilRadius;
						if(x+gun.x>stage.stage.mouseX){
							recoilRotation=startingRecoilRotation;
						} else if(x+gun.x<stage.stage.mouseX){
							recoilRotation=-startingRecoilRotation;
						}
						recoil=false;
					}
				} else {
					recoilRadius-=recoilRadiusRate;// goes from starting recoil position to normal position
				}
				if (recoilRotation>0) {
					if(recoilRotation-((recoilRotation/recoilRotationRate) + 1)>0){ //if going to be over 0 (so it doesn't rattle)
						recoilRotation-=(recoilRotation/recoilRotationRate) + 1;// Easing effect + 1 to make the very end faster
					} else {
						recoilRotation=0;
					}
				} else if(recoilRotation<0){
					if(recoilRotation-((recoilRotation/recoilRotationRate) - 1)<0){
						recoilRotation-=(recoilRotation/recoilRotationRate) - 1;// Easing effect + 1 to make the very end faster
					} else {
						recoilRotation=0;
					}
				}
			}
			////////////////////////////////X and Y////////////////////
			//Explanation gun.x = (dis betweeen mouse and gun)/recoilRadius + starting gun position
			//PREVIOUS LINE Explanation, (dis-gun.x)*.5; Easing
			gun.x += (((stage.mouseX-(x+gun.x))/recoilRadius+((x+body.x)))-(x+gun.x))*xyEase;
			gun.y += (((stage.mouseY-(y+gun.y))/recoilRadius+((y+body.y+gunYoffset)-(body.height/2)))-(y+gun.y))*xyEase;
			//////////////////////////Rotation////////////////////////
			//BAD CODE
			//Explanation: gets rid of recoil (subtracts recoilRotation number from previous)
			if (changeTimer==0) {
				gun.rotation-=recoilRotation+recoilRadiusRate;
				gun.rotation=degrees;
				//Adds recoil
				gun.rotation+=recoilRotation;
			} else {
				if (degrees<90) {
					final=degrees+270;
				} else {
					final=degrees-90;
				}
				if (gun.rotation<90) {
					initial=gun.rotation+270;
				} else {
					initial=gun.rotation-90;
				}
				if(changeTimer!=changeTimerStarting-1){//so first frame is 270 degrees; -1 is because changeTimer--; above
					gun.rotation+=(final-initial)*.5;
				} else {
					gun.rotation=270;
				}
			}
		}
		function noShootGun(e:MouseEvent):void {// MOUSE_UP
			shooting=false;
		}
	}
}
/*
package {
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class Character extends MovieClip {
		//http://help.adobe.com/en_US/ActionScript/3.0_ProgrammingAS3/WS5b3ccc516d4fbf351e63e3d118a9b90204-7f8a.html
		public var radius:Number=50;
		public var angle:Number=90;
		public var speed:Number=15;
		public const charstartx:Number=200;
		public const charstarty:Number=400;
		public const startx1:Number=0;
		public const starty1:Number=-10;
		public const startx2:Number=0;
		public const starty2:Number=0;
		public var pressedA:Boolean=false;
		public var pressedD:Boolean=false;
		public var moveLeft:int=1;//left = -1, stop = 0, right = 1
		public var lastKeyPress:String;//A or D
		public var lastMove:Number=radius/strideWidth;
		public var strideWidth:Number=1.5;//Larger = smaller stride; Smaller = larger stride
		public var breathing:Number=0;
		public const breathingrate:Number=1;

		//Jumping
		public var pressedW:Boolean=false;
		public var speedY:Number=0;
		public var speedX:Number=0;
		public const accelerationX:Number=1;
		public const gravity:Number=1.5;
		public const friction:Number=.95; //x axis only
		public const maxspeedX:Number=7; //jumping and moving on x axis
		public var jumping:Boolean=false;
		public const jumpingStrengthStart:Number=18;
		public var jumpingStrength:Number=jumpingStrengthStart;
		public var ground:Number=300;
		public var jumpfoot1x:Number=30;
		public var jumpfoot1y:Number=-10;
		public var jumpfoot2x:Number=-30;
		public var jumpfoot2y:Number=-10;
		public var jumpfootease:Number=5;//larger = longer
		public const jumpfootrotationstart:Number=30;
		public var jumpfootrotation:Number=jumpfootrotationstart;
		public var doublejumping:Boolean=false;
		public var letgoW:Boolean=false;//so double jump has to wait until w is let go and pressed again
		public var jump1ok:Boolean=false;//single jump
		public var jump2ok:Boolean=false;//single double jump

		/////////////////////////////GUN//////////////////////////////////////////////

		// Change shootingRate, startingRecoilRadius, normalRadius, recoilRadiusRate, startingRecoilRotation, recoilRotationRate
		public var shooting:Boolean;
		public var recoil:Boolean;
		public var gunYoffset:Number=20;
		public var shootingTimer:uint=0;// const
		// shootingRate MUST >= recoilRotationRate
		public const shootingRate:uint=10;// FPS = 30, 1/3 of second
		// Radius: The larger the number, the closer in
		public const startingRecoilRadius:Number=15;
		public const normalRadius:Number=7;
		public var recoilRadius:Number=normalRadius;// const; recoil startup value
		public var recoilRadiusRate:Number=1.5;// over 1 (error if <1)
		///////////////////////////////////////////
		public const startingRecoilRotation:int=40;//Degrees
		public var recoilRotation:Number=0;// const
		public var recoilRotationRate:uint=6;//Smaller = faster; shootingRate MUST >= recoilRotationRate
		public var radians:Number;
		public var degrees:Number=0;
		///////////////////////////////////////////
		public var pressedE:Boolean=false;
		public var pressedQ:Boolean=false;
		public var switchedGun:Boolean=false;//One time gun switch
		public const xyEase:Number=.5;//0 to 1
		public var changeTimer:uint=0;//const
		public const changeTimerStarting:uint=10; //changeing weapons wait before shooting
		public var final:Number=0;
		public var initial:Number=0;
		public var lastFacingLeft:Boolean=true;

		//////////////////////////////////////////////
		public function Character() {
			stage.addEventListener(Event.ENTER_FRAME, onLoop);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, checkGun);
			stage.addEventListener(MouseEvent.MOUSE_UP, noShootGun);
		}
		public function keyIsDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 65 ://a
					pressedA=true;
					break;
				case 67 ://e
					pressedE=true;
					break;
				case 68 ://d
					pressedD=true;
					break;
				case 81 ://q
					pressedQ=true;
					if (switchedGun==false) {//actually changing
						recoilRotation=0;
						gun.rotation=270;
						initial=0;
						if (degrees<90) {
							final=degrees+270;
						} else {
							final=degrees-90;
						}
						changeTimer=changeTimerStarting;
						recoilRadius=normalRadius;
						switchedGun=true;
						if (gun.currentFrame!=1) {
							gun.gotoAndStop(gun.currentFrame-1);
						} else {
							gun.gotoAndStop(gun.totalFrames);
						}
					}
					break;
				case 87 ://w
					pressedW=true;
					break;
			}
		}
		public function keyIsUp(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 65 ://a
					pressedA=false;
					lastKeyPress="A";
					break;
				case 68 ://d
					pressedD=false;
					lastKeyPress="D";
					break;
				case 87 ://w
					pressedW=false;
					break;
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
		public function checkGun(e:MouseEvent):void {// MOUSE_DOWN
			shooting=true;
		}
		function onLoop(event:Event):void {
			if(jumping==true&&pressedW==false){
				letgoW=true;
			}
			if(y>=ground&&pressedW==false){ //so resets jumping (jump only once)
				jump1ok=true;
				jump2ok=true;
			}
			//Jumping and y
			if (pressedW==true) {
				if (jumping==false) { //Jumping initializer Everything that happens once is here
					if(jump1ok==true){
						jump1ok=false;
					if(angle>=0&&angle<180){
						angle = 90;
					} else {
						angle = 270;
					}
					//foot1.rotation=0;
					//foot2.rotation=0;
					jumping=true;
					speedY=-jumpingStrength;
					}
				}
				if(jumping==true){
					if(letgoW==true){
						if(doublejumping==false){
							if(jump2ok==true){
								jump2ok=false;
							doublejumping=true;
							speedY=-jumpingStrength;
							//optional
							foot1.rotation=0;
							foot2.rotation=0;
							}
						}
					}
				}
			}
	
			if (pressedA==true) {
				moveLeft=-1;
			} else if (pressedD==true) {
				moveLeft=1;
			} else {
				moveLeft=0;
			}

			if(jumping==true){
				if(pressedA==true){
					if(speedX>=-maxspeedX){
						speedX-=accelerationX;
					}
				} else if(pressedD==true){
					if(speedX<=maxspeedX){
						speedX+=accelerationX;
					}
				}
				speedX*=friction;
				x+=speedX;
				
				if(x>stage.stage.mouseX){//mouse left
					jumpfootrotation= -jumpfootrotationstart;
					if(lastFacingLeft==true){
						foot1.rotation = -Math.abs(foot1.rotation);
						foot2.rotation = -Math.abs(foot2.rotation);
					}
				} else if(x<stage.stage.mouseX){//mouse right
					jumpfootrotation= jumpfootrotationstart;
					if(lastFacingLeft==false){
						foot1.rotation = Math.abs(foot1.rotation);
						foot2.rotation = Math.abs(foot2.rotation);
					}
				}
				//0-180 foot1 is on right, other on left
				if(angle>=0&&angle<180){ // makes sure that feet are separated and positioned according to where they were when jumped
					foot1.x += (jumpfoot1x-foot1.x)/jumpfootease;
					foot1.y += ((jumpfoot1y+starty1)-foot1.y)/jumpfootease;
					foot1.rotation += (jumpfootrotation-foot1.rotation)/jumpfootease;
					foot2.x += (jumpfoot2x-foot2.x)/jumpfootease;
					foot2.y += (jumpfoot2y-foot2.y)/jumpfootease;
					foot2.rotation += (jumpfootrotation-foot2.rotation)/jumpfootease;
				} else {
					foot1.x += (jumpfoot2x-foot1.x)/jumpfootease;
					foot1.y += ((jumpfoot1y+starty1)-foot1.y)/jumpfootease;
					foot1.rotation += (jumpfootrotation-foot1.rotation)/jumpfootease;
					foot2.x += (jumpfoot1x-foot2.x)/jumpfootease;
					foot2.y += (jumpfoot2y-foot2.y)/jumpfootease;
					foot2.rotation += (jumpfootrotation-foot2.rotation)/jumpfootease;
				}
			} else {
				if(pressedA==true){
					speedX=-speed/3;
				} else if(pressedD==true){
					speedX=speed/3;
				} else {
					speedX=0;
				}
			}
			
			if (y<ground) {
				speedY+=gravity;
			} else if(y>ground){
				jumping=false;
				doublejumping=false;
				letgoW=false;
				y=ground;
				speedY=0;
			}
			y+=speedY;
			if(jumping==false){
				if (moveLeft==1) {
					angle+=speed;
				} else if (moveLeft==-1) {
					angle-=speed;
				}
				if (moveLeft==0) {// if no keys pressed
					if (lastKeyPress=="A") {
						//foot1
						if (angle<=45||angle>270) {
							angle-=speed;
						} else if (angle>45&&angle<90) {
							angle+=speed;
						}
						//foot2
						if (angle>90&&angle<=215) {
							angle-=speed;
						} else if (angle<270&&angle>215) {
							angle+=speed;
						}
					} else if (lastKeyPress=="D") {
						//foot1
						if (angle<315&&angle>270) {
							angle-=speed;
						} else if (angle>=315||angle<90) {
							angle+=speed;
						}
						//foot2
						if (angle>90&&angle<=135) {
							angle-=speed;
						} else if (angle>135&&angle<270) {
							angle+=speed;
						}
					}
				}
			}
			//make sure angle is between 0 and 360
			if (angle<0) {
				angle+=360;
			} else if (angle>=360) {
				angle-=360;
			}
	
			//x based on lastx - shouldbex added to current x
			if(jumping==false){
				if(angle<90||angle>270){
					x-=lastMove-((radius*Math.cos((angle-90)*Math.PI/180))/strideWidth);
				} else if(angle>90&&angle<270){
					x+=lastMove-((radius*Math.cos((angle-90)*Math.PI/180))/strideWidth);
				}
			}
		
			//feet
			if(jumping==false){
				foot1.x = startx1+(radius*Math.cos((angle-90)*Math.PI/180))/strideWidth;
				foot2.x = startx2+(radius*Math.cos((angle+90)*Math.PI/180))/strideWidth;
			}
			//breathing
			//body.y += ((offset(average between feet y)- body.y)/easing;
			body.y += ((-10+((foot1.y+foot2.y)/2))-body.y)/10;
			breathing+=breathingrate/10;
			body.y += (Math.sin(breathing)*.5);
			body.x=0;
			//character direction
			if(x>stage.mouseX){//mouse right
				if(lastFacingLeft==true){
					lastFacingLeft=false;
					body.scaleX=-1;
					foot1.scaleX=-1;
					foot2.scaleX=-1;
				}
			} else if(x<stage.mouseX){//mouse left
				if(lastFacingLeft==false){
					lastFacingLeft=true;
					body.scaleX=1;
					foot1.scaleX=1;
					foot2.scaleX=1;
				}
			}

			lastMove=(radius*Math.cos((angle-90)*Math.PI/180))/strideWidth;//Keep at end!
	
			//Raising foot1
			if(jumping==false){
				if (angle>=270||angle<=90) {
					foot1.y=starty1+(radius*-Math.cos(angle*Math.PI/180));
				} else {
					foot1.y=starty1;
				}
				//Raising foot2
				if (angle<=270&&angle>=90) {
					foot2.y=starty2+(radius*Math.cos(angle*Math.PI/180));
				} else {
					foot2.y=starty2;
				}
	
				//Rotations
				//foot1
				if (angle>=270&&angle<315) {
					//angle 270 to 315
					//rot 0 to 45
					foot1.rotation=angle-270;
				} else if (angle>=315&&angle<360) {
					//angle 315 to 360
					//rot 45 to 0
					foot1.rotation = 90-(angle-270);
				} else if (angle>=0&&angle<45) {
					//angle 0 to 45
					//rot 0 to -45
					foot1.rotation=- angle;
				} else if (angle>=45&&angle<=90) {
					//angle 45 to 90
					//rot -45 to 0
					foot1.rotation=angle-90;
				} else {
					foot1.rotation=0;
				}
	
				//foot2
				if (angle>=90&&angle<135) {
					//angle 90 to 135
					//rot 0 to 45
					foot2.rotation=angle-90;
				} else if (angle>=135&&angle<180) {
					//angle 135 to 180
					//rot 45 to 0
					foot2.rotation = 90-(angle-90);
				} else if (angle>=180&&angle<225) {
					//angle 180 to 215
					//rot 0 to -45
					foot2.rotation= -(angle-180);
				} else if (angle>=215&&angle<=270) {
					//angle 215 to 270
					//rot -45 to 0
					foot2.rotation=angle-270;
				} else {
					foot2.rotation=0;
				}
			}
	
			if(y+(speedY*2)>=ground&&jumping==true){ //KEEP AT END, checks if going to be touching ground soon and makes feet more flat
				foot1.rotation/=2;
				foot2.rotation/=2;
			}
			//Gun
	
			////////////////////////////Gun Rotation////////////////////////////////
	
			radians=Math.atan2(stage.mouseY-(y+gun.y),stage.mouseX-(x+gun.x));
			degrees = Math.round((radians*180/Math.PI))+180;// Change the last number to change overall rotation
			if(x+gun.x>stage.stage.mouseX){
				gun.scaleY=1;
			} else if(x+gun.x<stage.stage.mouseX){
				gun.scaleY=-1;
			}
	
			///////////////////////////ShootingTimer///////////////////////////////	
			if (changeTimer==0) {
				if (shootingTimer==0) {
					if (shooting==true) {// Everything in here is what actually happens when shooting
					
						//var newBullet:bulletClass = new bulletClass();
						// CHANGE THE X AND Y VALUES
						//newBullet.x = x+gun.x;
						//newBullet.y = y+gun.y;
						//this.addChild(newBullet);
				
						//var newShell:shellClass = new shellClass();
						//newShell.x = x+gun.x;
						//newShell.y = y+gun.y;
						//this.addChild(newShell);
				
						recoil=true;
						shootingTimer=shootingRate;
					}
				}
			} else {
				changeTimer--;
			}
			if(shootingTimer!=0){
				shootingTimer--;
			}
			//////////////////////Recoil Radius////////////////////////
			if (changeTimer==0) {
				if (recoilRadius<=normalRadius) {
					if (recoil==true) {
						recoilRadius=startingRecoilRadius;
						if(x+gun.x>stage.stage.mouseX){
							recoilRotation=startingRecoilRotation;
						} else if(x+gun.x<stage.stage.mouseX){
							recoilRotation=-startingRecoilRotation;
						}
						recoil=false;
					}
				} else {
					recoilRadius-=recoilRadiusRate;// goes from starting recoil position to normal position
				}
				if (recoilRotation>0) {
					if(recoilRotation-((recoilRotation/recoilRotationRate) + 1)>0){ //if going to be over 0 (so it doesn't rattle)
						recoilRotation-=(recoilRotation/recoilRotationRate) + 1;// Easing effect + 1 to make the very end faster
					} else {
						recoilRotation=0;
					}
				} else if(recoilRotation<0){
					if(recoilRotation-((recoilRotation/recoilRotationRate) - 1)<0){
						recoilRotation-=(recoilRotation/recoilRotationRate) - 1;// Easing effect + 1 to make the very end faster
					} else {
						recoilRotation=0;
					}
				}
			}
			////////////////////////////////X and Y////////////////////
			//Explanation gun.x = (dis betweeen mouse and gun)/recoilRadius + starting gun position
			//PREVIOUS LINE Explanation, (dis-gun.x)*.5; Easing
			gun.x += (((stage.mouseX-(x+gun.x))/recoilRadius+((x+body.x)))-(x+gun.x))*xyEase;
			gun.y += (((stage.mouseY-(y+gun.y))/recoilRadius+((y+body.y+gunYoffset)-(body.height/2)))-(y+gun.y))*xyEase;
			//////////////////////////Rotation////////////////////////
			//BAD CODE
			//Explanation: gets rid of recoil (subtracts recoilRotation number from previous)
			if (changeTimer==0) {
				gun.rotation-=recoilRotation+recoilRadiusRate;
				gun.rotation=degrees;
				//Adds recoil
				gun.rotation+=recoilRotation;
			} else {
				if (degrees<90) {
					final=degrees+270;
				} else {
					final=degrees-90;
				}
				if (gun.rotation<90) {
					initial=gun.rotation+270;
				} else {
					initial=gun.rotation-90;
				}
				if(changeTimer!=changeTimerStarting-1){//so first frame is 270 degrees; -1 is because changeTimer--; above
					gun.rotation+=(final-initial)*.5;
				} else {
					gun.rotation=270;
				}
			}
		}
		function noShootGun(e:MouseEvent):void {// MOUSE_UP
			shooting=false;
		}
	}
}
*/