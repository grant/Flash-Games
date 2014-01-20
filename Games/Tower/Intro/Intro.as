package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Intro extends MovieClip {
		private var sparkles:Sparkles;
		public function Intro():void {
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			if(currentFrame==160){
				if(!MovieClip(parent).sparkling){
					MovieClip(parent).sparkling=true;
					sparkles = new Sparkles();
					addChild(sparkles);
				}
			} else if(currentFrame==250){
				stop();
				MovieClip(parent).playBtn.stop();
			} else if(currentFrame==251){
				sparkles.remove();
				removeEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
		public function remove():void {
			MovieClip(parent).removeChild(this);
		}
	}
}