/**
 * The close button to collapse the frame
 **/
package components {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class FrameCloseButton extends MovieClip {
		private var par:MovieClip;
		public function FrameCloseButton(px:int,py:int) {
			x = px;
			y = py;
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			this.buttonMode = true;
			addEventListener(MouseEvent.CLICK,onClick);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//Mouse Events
		/**
		 * Collapse the frame if it is expanded
		 **/
		private function onClick(e:MouseEvent):void {
			if(par.isExpanded()) {
				par.collapse();
			}
		}
	}
}