package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class BTN extends MovieClip {
		private var type:String;
		private var par:MovieClip;
		public function BTN(t:String,xPos:uint,yPos:uint,wid:uint,hei:uint) {
			type=t;
			x=xPos;
			y=yPos;
			width=wid;
			height=hei;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(MouseEvent.ROLL_OVER,onRoll);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);			
		}
		private function onClick(e:MouseEvent):void {
			switch (type) {
				case "quality" :
					if (stage.quality=="HIGH") {
						stage.quality="LOW";
					} else {
						stage.quality="HIGH";
					}
					break;
				case "restart":
					par.setBoard();
					par.resetMarbles();
					break;
			}
		}
		private function onRoll(e:MouseEvent):void {
			if(par.holdingMarble){
				par.addReturn(false,par.select.x,par.select.y);
				par.selectMarble(false);
			}
		}
		public function remove():void {
			removeEventListener(MouseEvent.ROLL_OVER,onRoll);
			removeEventListener(MouseEvent.CLICK,onClick);
			par.removeChild(this);
		}
	}
}