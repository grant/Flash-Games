package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class TileSelect extends MovieClip {
		private var par:MovieClip;
		private var frame:uint;
		public function TileSelect(f:uint,xPos:uint,yPos:uint,wid:uint,hei:uint) {
			frame = f;
			x = xPos;
			y = yPos;
			width = wid;
			height = hei;
			
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			gotoAndStop(frame);
			par = MovieClip(parent);
			addEventListener(MouseEvent.CLICK,onClick);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onClick(e:MouseEvent):void {
			par.selectedTile=frame;
		}
	}
}