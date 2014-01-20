package {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	public class TextBox extends Sprite {
		//"best"
		public var hsMin:uint=99;
		public var hsSec:uint=99;
		//"timer"
		public var min:uint=0;
		public var sec:uint=0;

		public var boxType:String;
		public function TextBox(type:String,xPos:int,yPos:int) {
			textBox.mouseEnabled=false;
			textBox.selectable=false;
			x=xPos;
			y=yPos;
			boxType=type;
			switch (boxType) {
				case "best" :
					updateText();
					break;
				case "timer" :
					addEventListener(Event.ENTER_FRAME,updateTimer);
					break;
			}
		}
		private var i:uint=0;
		private function updateTimer(e:Event):void {
			if (! MovieClip(parent.parent).win) {
				if (! MovieClip(parent.parent).dead) {
					if (! MovieClip(parent.parent).pausing) {
						if (i==24) {
							i=1;
							sec++;
							if (sec==60) {
								sec=0;
								min++;
							}
						} else {
							i++;
						}
					}
				}
			} else {
				if (MovieClip(parent.parent).hsMin>=min) {
					if (MovieClip(parent.parent).hsSec>sec) {
						MovieClip(parent.parent).hsMin=min;
						MovieClip(parent.parent).hsSec=sec;
						MovieClip(parent.parent).updateHS(min,sec);
					}
				}
			}
			var displayMin:String;
			var displaySec:String;
			if (min==0) {
				displayMin="00";
			} else if (min<10) {
				displayMin="0"+String(min);
			} else {
				displayMin=String(min);
			}
			if (sec==0) {
				displaySec="00";
			} else if (sec<10) {
				displaySec="0"+String(sec);
			} else {
				displaySec=String(sec);
			}
			if (min==60) {
				MovieClip(parent).removeGame();
			}

			textBox.text=displayMin+":"+displaySec;
			textBox.mouseEnabled=false;
			textBox.selectable=false;
		}
		public function updateText(m:uint=99,s:uint=99):void {
			hsMin = m;
			hsSec = s;
			if (hsMin!=99&&hsSec!=99) {
				var displayMin:String;
				var displaySec:String;
				if (hsMin==0) {
					displayMin="00";
				} else if (hsMin<10) {
					displayMin="0"+String(hsMin);
				} else {
					displayMin=String(hsMin);
				}
				if (hsSec==0) {
					displaySec="00";
				} else if (hsSec<10) {
					displaySec="0"+String(hsSec);
				} else {
					displaySec=String(hsSec);
				}
				textBox.text="Best: "+displayMin+":"+displaySec;
				textBox.mouseEnabled=false;
				textBox.selectable=false;
			}
		}
		public function remove():void {
			if (boxType=="timer") {
				removeEventListener(Event.ENTER_FRAME,updateTimer);
			}
			MovieClip(parent).removeChild(this);
		}
	}
}