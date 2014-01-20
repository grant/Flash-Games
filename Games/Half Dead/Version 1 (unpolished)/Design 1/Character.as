//To Do list:
//-2: Use the word "static" to create vars that can be access anywhere by stating Game.varName
//-1: Make spawn of bullets, deadBullets, and shells so not inside wall.=
//0: FIX SCOPE PROBLEM WITH SHELLS, BULLETS, ECT
//1: Make it so that feet wobbles over edge
//3: Add eyebrows, eyes, hair to body so you can rotate
//4: Make the position of the mouse rotate the body by half of what the actual angle is
//5: Ease the rotation of the above objective
//6: Make bullets not go through walls
//7: Make sparks come out when bullet or shell touches wall, make this proportional to the total speed (x and y speeds)
//8: Attach gun to body
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	public class Character extends MovieClip {

		public var foot1:Foot1;
		public var backHair:Hair;
		public var body:Body;
		public var nose:Nose;
		public var eye1:Eye;
		public var eye2:Eye;
		public var hair:Hair;
		public var eyebrow1:Eyebrow;
		public var eyebrow2:Eyebrow;
		public var foot2:Foot2;
		public var gun:Gun;

		public var par:MovieClip;

		public var angle:Number=90;
		public var radius:Number=50;
		public var strideWidth:Number=1.5;//Larger = smaller stride; Smaller = larger stride
		public var lastMove:Number=radius/strideWidth;

		public var speedX:Number=0;
		public const accelerationX:Number=1;
		public const frictionX:Number=.95;
		public var speed:Number=15;//also used for angle (feet)
		public var speedY:Number=0;
		public const maxSpeedY:Number=90;
		public var jumpingStrength:Number=18;

		public var lastFacingLeft:Boolean=false;
		public var moveLeft:int=0;

		public var hittingDown:Boolean=false;
		public var hittingLeft:Boolean=false;
		public var hittingRight:Boolean=false;
		public var hittingUp:Boolean=false;

		public var jumping:Boolean=true;
		public var jump1Ok:Boolean=false;
		public var jump2Ok:Boolean=false;
		public var doubleJumping:Boolean=false;
		public const gravity:Number=1.5;
		public const maxSpeedX:Number=7;

		public const jumpFootRotationStart:Number=30;
		public var jumpFootRotation:Number=jumpFootRotationStart;
		public var jumpFootEase:Number=5;//larger = longer
		public var jumpfoot1x:Number=30;
		public var jumpfoot1y:Number=-10;
		public var jumpfoot2x:Number=-30;
		public var jumpfoot2y:Number=-10;
		public const jumpFootFlatSpeed=2;

		public const startx1:Number=0;
		public const starty1:Number=0;
		public const startx2:Number=0;
		public const starty2:Number=5;

		public var pressedA:Boolean=false;
		public var pressedD:Boolean=false;
		public var pressedW:Boolean=false;
		public var letGoW:Boolean=false;
		public var lastKeyPress:String;

		public var onGround:Boolean=false;
		public var prevOnGround:Boolean=false;
		private var wallTouchEase=.5;

		public function Character(xPos:Number,yPos:Number) {
			
			x = xPos;
			y = yPos;
			
			foot1=new Foot1(1);
			addChild(foot1);

			backHair=new Hair(1);
			addChild(backHair);

			body = new Body();
			addChild(body);

			nose=new Nose(1,25,-35);//frame #,x,y
			addChild(nose);

			eye1=new Eye(1,10,-60);//frame #,x,y
			addChild(eye1);

			eye2=new Eye(1,45,-60);//frame #,x,y
			addChild(eye2);

			foot2=new Foot2(1);
			addChild(foot2);

			hair=new Hair(2);
			addChild(hair);

			eyebrow1=new Eyebrow(1,10,-80);//frame #,x,y
			addChild(eyebrow1);

			eyebrow2=new Eyebrow(2,45,-80);//frame #,x,y
			addChild(eyebrow2);

			gun=new Gun();
			addChild(gun);

			addEventListener(Event.ADDED_TO_STAGE,setExternalVars);
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		public function setExternalVars(e:Event):void {
			if (parent is MovieClip) {//check parents only
				par=MovieClip(parent);//par = parent
				//trace(par.foot1.y); example
			}
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyIsUp);
		}
		public function keyIsDown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 65 ://a
					pressedA=true;
					break;
				case 68 ://d
					pressedD=true;
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
			}
		}
		public function onLoop(e:Event):void {
			if (onGround==false&&pressedW==false) {
				letGoW=true;
			}
			if (onGround==true&&pressedW==false) {//so resets jumping (jump only once)
				jump1Ok=true;
				jump2Ok=true;
			}
			//Jumping and y
			if (pressedW==true) {
				if (onGround==true) {//Jumping initializer Everything that happens once is here
					if (jump1Ok==true) {
						jump1Ok=false;
						//foot1.rotation=0;
						//foot2.rotation=0;
						speedY=- jumpingStrength;
					}
				}
				if (onGround==false) {
					if (letGoW==true) {
						if (jump2Ok==true) {
							jump2Ok=false;
							speedY=- jumpingStrength;
							//optional
							foot1.rotation=0;
							foot2.rotation=0;
						}
					}
				}
			}//end pressedW
			y+=speedY;
			if (onGround==false) {
				if (pressedA==true) {
					if (speedX>=- maxSpeedX) {
						speedX-=accelerationX;
					}
				} else if (pressedD==true) {
					if (speedX<=maxSpeedX) {
						speedX+=accelerationX;
					}
				}
				speedX*=frictionX;
				x+=speedX;

				if (x>stage.mouseX) {//mouse left
					jumpFootRotation=- jumpFootRotationStart;
					//OPTIONAL
					//foot1.rotation=- Math.abs(foot1.rotation);
					//foot2.rotation=- Math.abs(foot2.rotation);
				}
				if (x<stage.mouseX) {//mouse right
					jumpFootRotation=jumpFootRotationStart;
					//OPTIONAL
					//foot1.rotation=Math.abs(foot1.rotation);
					//foot2.rotation=Math.abs(foot2.rotation);
				}
				//0-180 foot1 is on right, other on left
				if (angle>=0&&angle<180) {// makes sure that feet are separated and positioned according to where they were when jumped
					foot1.x += (jumpfoot1x-foot1.x)/jumpFootEase;
					foot1.y += ((jumpfoot1y+starty1)-foot1.y)/jumpFootEase;
					foot1.rotation += (jumpFootRotation-foot1.rotation)/jumpFootEase;
					foot2.x += (jumpfoot2x-foot2.x)/jumpFootEase;
					foot2.y += (jumpfoot2y-foot2.y)/jumpFootEase;
					foot2.rotation += (jumpFootRotation-foot2.rotation)/jumpFootEase;
				} else {
					foot1.x += (jumpfoot2x-foot1.x)/jumpFootEase;
					foot1.y += ((jumpfoot1y+starty1)-foot1.y)/jumpFootEase;
					foot1.rotation += (jumpFootRotation-foot1.rotation)/jumpFootEase;
					foot2.x += (jumpfoot1x-foot2.x)/jumpFootEase;
					foot2.y += (jumpfoot2y-foot2.y)/jumpFootEase;
					foot2.rotation += (jumpFootRotation-foot2.rotation)/jumpFootEase;
				}
			} else {// on ground
				if (pressedA==true) {
					speedX=- speed/3;
				} else if (pressedD==true) {
					speedX=speed/3;
				} else {
					speedX*=.1;
				}
			}
			if (pressedA==true) {
				moveLeft=-1;
			} else if (pressedD==true) {
				moveLeft=1;
			} else {
				moveLeft=0;
			}


			var touchingSide:Boolean=false;
			for (var f = 0; f<par.groundHolder.length; f++) {//wall collisions
				if (par.groundHolder[f].hitTestPoint(x+(body.width/2),y+body.bodyOffset-(body.width/2))) {//touching right middle
					x += ((par.groundHolder[f].x-(body.width/2))-x)*wallTouchEase;
					touchingSide=true;
				}
				if (par.groundHolder[f].hitTestPoint(x-(body.width/2),y+body.bodyOffset-(body.width/2))) {//touching left middle
					x += ((par.groundHolder[f].x+par.groundHolder[f].width+(body.width/2))-x)*wallTouchEase;
					touchingSide=true;
				}
				
				//the following conditional statement is so the easing isn't messed up with the corner ground collisions
				if (par.groundHolder[f].hitTestPoint(x+(body.width/2),y+body.bodyOffset-(body.width/2))==false&&par.groundHolder[f].hitTestPoint(x-(body.width/2),y+body.bodyOffset-(body.width/2))==false) {//if two previous statements are false
					//Finds distance between the corners of the ground and makes the x correct if distance is smaller than the body radius
					//TOP LEFT GROUND
					var xDis:Number = (x-par.groundHolder[f].x)*(x-par.groundHolder[f].x);
					var yDis:Number = ((y+body.bodyOffset-(body.width/2))-par.groundHolder[f].y)*((y+body.bodyOffset-(body.width/2))-par.groundHolder[f].y);
					if (Math.sqrt(xDis+yDis)<(body.width/2)) {//top left corner
						x += ((par.groundHolder[f].x - Math.sqrt(((body.width/2)*(body.width/2))-yDis))-x)*wallTouchEase;
					}

					//TOP RIGHT GROUND
					var xDis2:Number = (x-(par.groundHolder[f].x+par.groundHolder[f].width))*(x-(par.groundHolder[f].x+par.groundHolder[f].width));
					var yDis2:Number = ((y+body.bodyOffset-(body.width/2))-par.groundHolder[f].y)*((y+body.bodyOffset-(body.width/2))-par.groundHolder[f].y);
					if (Math.sqrt(xDis2+yDis2)<=(body.width/2)) {//top right corner
						x += ((par.groundHolder[f].x + par.groundHolder[f].width + Math.sqrt(((body.width/2)*(body.width/2))-yDis2))-x)*wallTouchEase;
					}
				}
			}


			if (onGround==true) {
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
			onGround=false;
			for (var i = 0; i<par.groundHolder.length; i++) {//ground collision
				if (par.groundHolder[i].hitTestPoint(x,y)) {//+body.bodyOffset)) {//touching ground
					onGround=true;
					speedY=0;
					y=par.groundHolder[i].y;//-body.bodyOffset;
				}
				if (par.groundHolder[i].hitTestPoint(x+(body.width/4),y)||par.groundHolder[i].hitTestPoint(x-(body.width/4),y)) {//on left or right edge
					if (y+body.y<par.groundHolder[i].y) {//if(bottom of body < ground.y){ (no glitching)
						if(speedY>=0){// if falling
							onGround=true;
							speedY=0;
							y=par.groundHolder[i].y;
						}
					}
				}
			}
			if (onGround==true) {
				if (prevOnGround==false) {// just touched down, calls once
					foot1.x=jumpfoot1x;
					foot1.y=jumpfoot1y;
					foot2.x=jumpfoot2x;
					foot2.y=jumpfoot2y;
					if (angle>=0&&angle<180) {
						angle=90;
						//foot1.rotation=angle+90;
						//foot2.rotation=angle+90;
					} else {
						angle=270;
						//foot1.rotation=angle-90;
						//foot2.rotation=angle-90;
					}
					//resets going-to-be x speed
					if (angle<90||angle>270) {
						lastMove=((radius*Math.cos((angle-90)*Math.PI/180))/strideWidth);
					} else if (angle>90&&angle<270) {
						lastMove=-((radius*Math.cos((angle-90)*Math.PI/180))/strideWidth);
					}
				}
			}
			prevOnGround=onGround;
			//x based on lastx - shouldbex added to current x
			if (onGround==true) {
				if (angle<90||angle>270) {
					x-=lastMove-((radius*Math.cos((angle-90)*Math.PI/180))/strideWidth);
				} else if (angle>90&&angle<270) {
					x+=lastMove-((radius*Math.cos((angle-90)*Math.PI/180))/strideWidth);
				}
				lastMove=(radius*Math.cos((angle-90)*Math.PI/180))/strideWidth;//Keep at end!
			}
			if (onGround==false) {//in air
				speedY+=gravity;
				if (speedY>maxSpeedY) {
					speedY=maxSpeedY;
				}
			} else {//on ground
				letGoW=false;
			}
			//feet
			if (onGround==true) {
				//foot x positions
				foot1.x = startx1+(radius*Math.cos((angle-90)*Math.PI/180))/strideWidth;
				foot2.x = startx2+(radius*Math.cos((angle+90)*Math.PI/180))/strideWidth;

				//Raising foot1
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
		}
	}
}