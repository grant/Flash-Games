package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Hs extends MovieClip {
		public function Hs(xPos:uint,yPos:uint) {
			x = xPos;
			y = yPos;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		public function onAdd(e:Event):void {
			textBox.mouseEnabled=false;
			textBox.selectable=false;
			textBox.text = "Your cell could not evolve.";
			textBox2.mouseEnabled=false;
			textBox2.selectable=false;
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
			textBox2.text = "Time lasted: "+displayMin+":"+displaySec+".";
		}
	}
}