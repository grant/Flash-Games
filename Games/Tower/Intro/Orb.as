package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Orb extends MovieClip {
		private var fastForward:Boolean = false;
		private var defaultSize:Number = width;
		private var scaleUp:Number = 1.2;
		public function Orb():void {
			addEventListener(MouseEvent.CLICK,onClick);
			addEventListener(MouseEvent.ROLL_OVER,onInRoll);
			addEventListener(MouseEvent.ROLL_OUT,onOutRoll);
		}
		private function onClick(e:MouseEvent):void {
			if(!fastForward){
				fastForward=true;
				addEventListener(Event.ENTER_FRAME,fast);
			}
		}
		private function fast(e:Event):void {
			if(MovieClip(parent).currentFrame<=250-3){//intro
				MovieClip(parent.parent).intro.gotoAndStop(MovieClip(parent).currentFrame+3);
				MovieClip(parent).gotoAndStop(MovieClip(parent).currentFrame+3);
			} else if(MovieClip(parent).currentFrame<270){
				MovieClip(parent.parent).intro.gotoAndStop(MovieClip(parent).currentFrame+1);
				MovieClip(parent).gotoAndStop(MovieClip(parent).currentFrame+1);
			} else {
				MovieClip(parent.parent).addBg();
				removeEventListener(Event.ENTER_FRAME,fast);
				MovieClip(parent.parent).intro.remove();
				MovieClip(parent.parent).removeChild(MovieClip(parent));
			}
		}
		private function onInRoll(e:MouseEvent):void {
			if(MovieClip(parent).currentFrame>=208&&MovieClip(parent).currentFrame<=250){
				width = scaleUp*defaultSize;
				height = scaleUp*defaultSize;
			}
			addEventListener(Event.ENTER_FRAME,addButterflies);
		}
		private function onOutRoll(e:MouseEvent):void {
			if(MovieClip(parent).currentFrame>=208&&MovieClip(parent).currentFrame<=250){
				width = defaultSize;
				height = defaultSize;
			}
			removeEventListener(Event.ENTER_FRAME,addButterflies);
		}
		private function addButterflies(e:Event):void {
			var butterfly:Butterfly = new Butterfly(x,y);
			MovieClip(parent.parent).butterflies.addChild(butterfly);
		}
	}
}