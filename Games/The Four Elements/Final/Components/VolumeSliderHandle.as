//par:VolumeSlider
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class VolumeSliderHandle extends MovieClip {
		//constants
		private const sliderDragEase:Number = .94;
		
		private var topY:int;
		private var bottomY:int;
		
		private var desY:int;
		private var isSelected:Boolean=false;
		
		private var par:MovieClip;
		public function VolumeSliderHandle(topY:int,bottomY:int):void {
			this.topY = topY;
			this.bottomY = bottomY;
			desY = topY;
			y = desY;
			buttonMode = true;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			addEventListener(MouseEvent.MOUSE_DOWN,mouseIsDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseIsUp);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//mouse is down
		private function mouseIsDown(e:MouseEvent):void {
			isSelected = true;
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		
		//mouse is up
		private function mouseIsUp(e:MouseEvent):void {
			isSelected = false;
			removeEventListener(Event.ENTER_FRAME,onLoop);
		}
		
		//on a loop
		private function onLoop(e:Event):void {
			if(isSelected) {
				desY = par.mouseY;
				if(desY>bottomY) {
					desY = bottomY;
				} else if(desY<topY) {
					desY = topY
				}
			}
			y = desY;
			par.updateVolume(getVolume());
		}
		
		//sets an absolute position
		public function setPosition(vol:Number):void {
			isSelected = false;
			desY = Math.abs((topY+((bottomY-topY)*vol))-(bottomY-topY));
			y = desY;
		}
		
		//gets the volume based on the slider's position
		private function getVolume():Number {
			return 1-((y-topY)/(bottomY-topY));
		}
	}
}