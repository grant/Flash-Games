package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Main extends MovieClip {
		public var credits:Boolean = false;
		public var blackFade:BlackFade;
		public var sparkling:Boolean=false;
		public var intro:Intro = new Intro();
		private var bg:Bg = new Bg();
		private var bg2:Bg2 = new Bg2();
		public var butterflies:MovieClip = new MovieClip();
		public var playBtn:PlayBtn = new PlayBtn();
		public function Main():void {
			addChild(bg);
			addChild(intro);
			addChild(butterflies);
			addChild(playBtn);
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onLoop(e:Event):void {
			createSpark(1);
		}
		public function createSpark(amount:uint):void {
			for (var a:uint =0; a<amount; a++) {
				var spark:Sparks=new Sparks(stage.mouseX,stage.mouseY);
				addChild(spark);
			}
		}
		public function addFade():void {
			blackFade = new BlackFade();
			addChild(blackFade);
		}
		public function addBg():void {
			addChild(bg2);
		}
	}
}