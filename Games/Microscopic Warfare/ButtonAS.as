package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	public class ButtonAS extends MovieClip {
		private var type:String;
		private var par:MovieClip;
		private var par2:MovieClip;
		private var death:Boolean;
		public function ButtonAS(textName:String,xPos:int,yPos:int,wid:uint,hei:uint,removeDeath:Boolean=false) {
			stop();
			x=xPos;
			y=yPos;
			width=wid;
			height=hei;
			death=removeDeath;
			type=textName;
			switch (type) {
				case "play" :
					textBox.text="Play!";
					break;
				case "menu" :
					textBox.text="Menu";
					break;
				case "pause" :
					textBox.text="Pause";
					break;
				case "restart" :
					textBox.text="Restart";
					break;
				case "music" :
					textBox.text="Music";
					break;
			}
			textBox.mouseEnabled=false;
			textBox.selectable=false;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(MouseEvent.CLICK,onClick);
			addEventListener(MouseEvent.ROLL_OVER,onEnter);
			addEventListener(MouseEvent.ROLL_OUT,onExit);
		}
		private function onAdd(e:Event):void {
			par=MovieClip(parent);
			if (! death) {
				par2=MovieClip(par.parent);
			}
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onClick(e:MouseEvent):void {
			switch (type) {
				case "play" :
					par2.removeMenu();
					par2.setGame();
					break;
				case "menu" :
					if (! death) {
						par2.removeGame();
						par2.displayMenu();
					} else {
						par.removeGame();
						par.displayMenu();
					}
					break;
				case "pause" :
					if (par2.playingGame) {
						if (! par2.pausing) {
							par2.addChild(par2.bp);
							par2.pausing=true;
						} else {
							par2.removeChild(par2.bp);
							par2.pausing=false;
						}
					}
					break;
				case "restart" :
					if (! death) {
						par2.removeGame();
						par2.setGame();
					} else {
						par.removeGame();
						par.setGame();
					}
					break;
				case "music" :
					par2.toggleMusic();
					break;
			}
			if (death) {
				par.removeDeath();
			}
		}
		private function onEnter(e:MouseEvent):void {
			gotoAndStop(2);
			textBox.mouseEnabled=false;
			textBox.selectable=false;
		}
		private function onExit(e:MouseEvent):void {
			gotoAndStop(1);
		}
		public function remove():void {
			removeEventListener(MouseEvent.ROLL_OVER,onEnter);
			removeEventListener(MouseEvent.ROLL_OUT,onExit);
			par.removeChild(this);
		}
	}
}