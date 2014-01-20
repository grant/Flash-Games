//par:Game
//par3:Page
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class SelectionWheel extends MovieClip {
		//constants
		private const rotEase:Number = .1;//how fast the wheel rotates
		
		//variables
		private var wheelMarbles:Array;
		private var rot:Number = 0;//current rotation
		private var desRot:Number = 0;//sets the destinated rotation
		private var levelsUnlocked:uint = 1;//number of levels unlocked
		private var elementId:uint;//the element marble it starts on
		
		//parents
		private var par:MovieClip;
		private var par3:MovieClip;
		public function SelectionWheel(elementId:uint,px:int,py:int):void {
			this.elementId = elementId;
			x = px;
			y = py;
			width = 100;
			height = 100;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			par3 = MovieClip(parent.parent.parent);
			setWheelMarbles();
			moveMarbles();
			setRotate(getRotation());
			addEventListener(MouseEvent.ROLL_OVER,onRoll);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//constructs the wheel marbles
		private function setWheelMarbles():void {
			wheelMarbles = new Array();

			wheelMarbles.push(new WheelMarble("earth"));
			wheelMarbles.push(new WheelMarble("water"));
			wheelMarbles.push(new WheelMarble("air"));
			wheelMarbles.push(new WheelMarble("fire"));
			
			for(var i:uint = 0;i<wheelMarbles.length;i++) {
				addChild(wheelMarbles[i]);
			}
			
			updateLocks();
		}
		
		//updates the locks according to the number of levels unlocked
		private function updateLocks():void {
			if(wheelMarbles!=null) {
				for(var i:uint = 0;i<wheelMarbles.length;i++) {
					if(i<levelsUnlocked) {
						wheelMarbles[i].setLock("invisible");
					} else {
						wheelMarbles[i].setLock("locked");
					}
				}
			}
		}
		
		//moves the marbles according to their circular rotation
		private function moveMarbles():void {
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			if(desRot==0&&rot>180) {
				if(rot>0) {
					rot -= 360;
				}
				rot += (desRot-rot)*rotEase;
			} else if(desRot==270&&rot<90) {
				if(rot<270) {
					rot += 360;
				}
			}
			rot += (desRot-rot)*rotEase;
			for(var i:uint = 0;i<wheelMarbles.length;i++) {
				wheelMarbles[i].setRot(rot);
			}
		}
		
		//Sets the destination rotation
		public function rotateTo(degree:uint):void {
			desRot = degree;
		}
		
		//rotates directly to the degree
		public function setRotate(degree:uint):void {
			desRot = degree;
			rot = degree;
		}
		
		//updates the number of levels unlocked 
		public function updateLevelsUnlocked(levels:uint):void {
			levelsUnlocked = Math.max(levels,levelsUnlocked);
			updateLocks();
		}
		
		//goes to the level
		public function goto(levelName:String):void {
			par.changeLevel(levelName);
		}
		
		//when rolled over
		private function onRoll(e:MouseEvent):void {
			//check to display message
			//if next level not unlocked, show message
			var levelsUnlocked = par3.getLevelsUnlocked();
			var currentLevel = par3.getCurrentLevel();
			if(levelsUnlocked==currentLevel&&currentLevel!=4) {
				par3.getUnlockingLabel().appear();//makes the message appear
			}
		}
		
		//disables all marbles from being clicked
		public function disableMarbles():void {
			for(var i:uint = 0;i<wheelMarbles.length;i++) {
				wheelMarbles[i].disableMarble();
			}
		}
		
		//gets the element rotation based on the element id
		private function getRotation():uint {
			switch(elementId) {
				case 1:
					return 180;
				break;
				case 2:
					return 90;
				break;
				case 3:
					return 0;
				break;
				case 4:
					return 270;
				break;
				default:
					return 0;
			}
		}
		
		//gets the game
		public function getGame():MovieClip {
			return par;
		}
	}
}