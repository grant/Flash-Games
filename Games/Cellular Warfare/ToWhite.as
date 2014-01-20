package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class ToWhite extends MovieClip {
		public var par:MovieClip;
		public function ToWhite() {
			stop();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			play();
			par = MovieClip(parent);
			MovieClip(parent).addHS();
			addEventListener(Event.ENTER_FRAME,onLoop);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		private function onLoop(e:Event):void {
			if(this.currentFrame==totalFrames){
				stop();
				removeEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
		private function onClick(e:MouseEvent):void {
			removeEventListener(MouseEvent.CLICK,onClick);
			MovieClip(parent).removeChild(MovieClip(parent).endHS);
			MovieClip(parent).removeChild(this);
			par.removeGame();
			par.displayMenu();
		}
	}
}