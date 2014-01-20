package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	public class Main extends MovieClip {
		
		private const FPS:uint = 25;
		private var frame:uint;//current frame number
		private var gameTimer:Timer;
		private var bg:BgColor;
		public function Main():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			addBackground();
			addTimer();
			addEventListener(Event.ENTER_FRAME,onLoop);
			stage.addEventListener(MouseEvent.CLICK,onClick);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		/**
		 * On mouse click
		 **/
		private function onClick(e:MouseEvent):void {
			bg.setTransition(frame,new RGBColor(0,0,0),40);
		}
		
		
		/**
		 * Adds the background to the stage
		 **/
		private function addBackground():void {
			bg = new BgColor();
			addChild(bg);
		}
		
		/**
		 * Adds the game timer
		 **/
		private function addTimer():void {
			gameTimer = new Timer(1000/FPS);
			gameTimer.start();
		}
		
		/**
		 * Only enter frame event listener loop in the game
		 **/
		private function onLoop(e:Event):void {
			frame = gameTimer.currentCount;
			bg.update(frame);
		}
	}
}