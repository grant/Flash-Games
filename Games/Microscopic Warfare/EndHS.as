package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class EndHS extends MovieClip {
		public function EndHS(xPos:uint,yPos:uint) {
			x = xPos;
			y = yPos;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		public function onAdd(e:Event):void {
			textBox.mouseEnabled=false;
			textBox.selectable=false;
			var displayMin:String;
			var displaySec:String;
			if (MovieClip(parent).timer.min==0) {
				displayMin="00";
			} else if (MovieClip(parent).timer.min<10) {
				displayMin="0"+String(MovieClip(parent).timer.min);
			} else {
				displayMin=String(MovieClip(parent).timer.min);
			}
			if (MovieClip(parent).timer.sec==0) {
				displaySec="00";
			} else if (MovieClip(parent).timer.sec<10) {
				displaySec="0"+String(MovieClip(parent).timer.sec);
			} else {
				displaySec=String(MovieClip(parent).timer.sec);
			}
			textBox.text = "Time: "+displayMin+":"+displaySec+".";
		}
	}
}