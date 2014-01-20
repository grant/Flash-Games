package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class SelectionWheel extends MovieClip {
		private const rotEase:Number = .1;//how fast the wheel rotates
		
		private var wheelMarbles:Array;
		private var rot:Number = 0;//current rotation
		private var desRot:Number = 0;//sets the destinated rotation
		private var levelsUnlocked:uint = 1;//number of levels unlocked
		public function SelectionWheel():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			setWheelMarbles();
			moveMarbles();
			setRotate(180);
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
			for(var i:uint = 0;i<wheelMarbles.length;i++) {
				if(i<levelsUnlocked) {
					wheelMarbles[i].setLock("invisible");
				} else {
					wheelMarbles[i].setLock("locked");
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
			levelsUnlocked = levels;
			updateLocks();
		}
	}
}