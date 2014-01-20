/**
 * Changes the quality of the game
 **/
package buttons {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class QualityButton extends MovieClip {
		private var qualityName:String;
		public function QualityButton(qualityName:String,px:uint,py:uint):void {
			this.qualityName = qualityName;
			x = px;
			y = py;
			this.buttonMode = true;
			setFrame()
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			addEventListener(MouseEvent.CLICK,onClick,false,0,true);
		}
		
		/**
		 * Sets the button's frame
		 **/
		private function setFrame():void {
			switch(qualityName) {
				case "high":
					gotoAndStop(1);
					break;
				case "medium":
					gotoAndStop(2);
					break;
				case "low":
					gotoAndStop(3);
					break;
			}
		}
		
		/**
		 * Change the quality when clicked
		 **/
		private function onClick(e:Event):void {
			stage.quality = qualityName;
		}
	}
}