package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class StaticMarble extends MovieClip {
		//constructors
		private var px:uint;//map x position
		private var py:uint;//map y position
		private var SIZE:uint;//size
		private var SPACING:uint;//spacing
		private var offx:uint;//offset x
		private var offy:uint;//offset y
		
		private var elementName:String;//element of the marble
		
		private var disabled:Boolean = false;//if disabled or not
		
		private var par2:MovieClip;
		public function StaticMarble(px:uint,py:uint,size:uint,spacing:uint,offx:uint,offy:uint):void {
			this.px = px;
			this.py = py;
			this.SIZE = size;
			this.SPACING = spacing;
			this.offx = offx;
			this.offy = offy;
			
			width = SIZE;
			height = SIZE;
			x = offx + (px*SPACING);
			y = offy + (py*SPACING);
			
			buttonMode = true;
			stop();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par2 = MovieClip(parent.parent.parent);
			addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//when clicked
		private function onDown(e:MouseEvent):void {
			if(!disabled) {
				selectMarble();
			}
		}
		
		//selects the marble
		private function selectMarble():void {
			if(!par2.hasSelected()) {
				hasMarble(false);
				par2.addSelectedMarble(px,py);
			}
		}
		
		//deselects the marble
		private function deselectMarble():void {
			hasMarble(true);
		}
		
		//sets the type of marble
		public function setType(type:String):void {
			this.elementName = type;
			switch (elementName) {
				case "earth" :
					gotoAndStop(1);
					break;
				case "water" :
					gotoAndStop(2);
					break;
				case "air" :
					gotoAndStop(3);
					break;
				case "fire" :
					gotoAndStop(5);
					break;
			}
		}
		
		//sets if the marble is there or not
		public function hasMarble(has:Boolean):void {
			visible = has;
		}
		
		//gets the position of the marble
		public function getPosition():Array {
			return new Array(px,py);
		}
		
		//sets if the marble is disabled or not
		public function disable(yes:Boolean) {
			disabled = yes;
		}
	}
}