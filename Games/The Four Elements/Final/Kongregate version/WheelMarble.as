//par:SelectionWheel
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class WheelMarble extends MovieClip {
		private const radius:uint = 75;
		
		private var type:String;//"earth","water","air","fire"
		private var wheelDegree:uint;//top = 0,right = 90,bottom = 180,left = 270
		private var lock:Lock;//lock object (185:225 proportions)
		private var disabled:Boolean = false;//can click the button
		
		private var lockPosition:String = "locked";
		
		private var par:MovieClip;//seleciton wheel
		public function WheelMarble(type:String):void {
			this.type = type;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			this.buttonMode = true;
			setType();
			addClick();
			addLock();
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//adds a lock (in the locked position)
		private function addLock():void {
			lock = new Lock();
			lock.x = 0;
			lock.y = 20;
			lock.width = 30;//18
			lock.height = 38;//22
			lock.rotation = 40;
			addChild(lock);
			updateLock();
		}
		
		//updates the lock
		private function updateLock():void {
			switch(lockPosition) {
				case "locked":
					disabled = true;
					lock.visible = true;
					lock.gotoAndStop(1);
					break;
				case "unlocked":
					disabled = false;
					lock.visible = true;
					lock.gotoAndStop(2);
					addEventListener(Event.ENTER_FRAME,unlockAnimation);
					break;
				case "invisible":
					disabled = false;
					lock.visible = false;
					break;
			}
		}
		
		//sets the lock position
		public function setLock(position:String):void {
			lockPosition = position;
			updateLock();
		}
		
		//sets the frame and parameters of the marble
		private function setType():void {
			switch(type) {
				case "earth":
					gotoAndStop(1);
					wheelDegree = 270;
					break;
				case "water":
					gotoAndStop(2);
					wheelDegree = 0;
					break;
				case "air":
					gotoAndStop(3);
					wheelDegree = 90;
					break;
				case "fire":
					gotoAndStop(4);
					wheelDegree = 180;
					break;
			}
		}
		
		//adds the clicking funtion
		private function addClick():void {
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		//clicking event
		private function onClick(e:MouseEvent):void {
			if(!disabled) {
				if(par.getGame().getMapName()!=type) {// a different map than the current one
					par.disableMarbles();
					switch(type) {
						case "earth":
							par.rotateTo(180);
							break;
						case "water":
							par.rotateTo(90);
							break;
						case "air":
							par.rotateTo(0);
							break;
						case "fire":
							par.rotateTo(270);
							break;
					}
					par.goto(type);
				}
			}
		}
		
		//sets the rotation
		public function setRot(rot:Number):void {
			var rad:Number = (rot+wheelDegree) * (Math.PI / 180);
    		x = radius * Math.cos(rad);
    		y = radius * Math.sin(rad);
		}
		
		//manages the unlock animation
		private function unlockAnimation(e:Event):void {
			lock.alpha-=.005;
			if(lock.alpha<=0) {
				setLock("invisible");
				removeEventListener(Event.ENTER_FRAME,unlockAnimation);
			}
		}
		
		//disables the marble
		public function disableMarble():void {
			disabled = true;
		}
	}
}