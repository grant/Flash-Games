package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Tile extends MovieClip {
		public var touches:uint=0;
		private var xTile:uint;
		private var yTile:uint;
		private var mouseIsDown:Boolean=false;
		private var f:uint;
		private var par:MovieClip;
		public function Tile(frame:uint,tileX:uint,tileY:uint,wid:uint,hei:uint) {
			f=frame;
			xTile=tileX;
			yTile=tileY;
			width=wid;
			height=hei;
			touchText.selectable=false;
			touchText.mouseEnabled=false;
			updateTouchText();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(MouseEvent.MOUSE_OVER,onOver);
			addEventListener(MouseEvent.MOUSE_DOWN,onClick);
		}
		private function onAdd(e:Event):void {
			par=MovieClip(parent);
			if (f>0&&f<=totalFrames) {//check if there is this frame (+1 b/c mouse)
				gotoAndStop(f);
				if (par.textVisible[f-1]==0) {//if wall
					touchText.visible=false;
				} else {
					if(par.numDisabled){
						touchText.visible=false;
					}
					updateTouchText();
				}
			} else {
				if (f!=3) {//if not mouse tile
					error();
				}
			}
			x = par.xOff+(xTile*width);
			y = par.yOff+(yTile*height);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onDown);
			stage.addEventListener(MouseEvent.MOUSE_UP,onUp);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onDown(e:MouseEvent):void {
			mouseIsDown=true;
		}
		private function onUp(e:MouseEvent):void {
			mouseIsDown=false;
		}
		private function onOver(e:MouseEvent):void {
			if (mouseIsDown) {
				addTile();
			}
		}
		private function onClick(e:MouseEvent):void {
			addTile();
		}
		private function addTile():void {
			if (par.settingMap) {
				//Note:
				//1st removes all seekers
				//2nd changes maps/tiles
				//3rd adds Seekers
				par.removeSeekers();
				if (par.selectedTile!=3) {//if not mouse tile
					if (par.selectedTile>3) {//b/c mouse
						par.map[yTile][xTile]=par.selectedTile-1;
					} else {
						par.map[yTile][xTile]=par.selectedTile;
					}
					par.removeChild(par.tiles[xTile][yTile]);
					par.addTile(xTile,yTile);
					if (par.seekersMap[yTile][xTile]!=0) {
						par.seekersMap[yTile][xTile]=0;
					}
				} else {//if mouse tile
					if (par.map[yTile][xTile]!=1) {
						par.map[yTile][xTile]=1;
						par.removeChild(par.tiles[xTile][yTile]);
						par.addTile(xTile,yTile);
					}
					if (par.seekersMap[yTile][xTile]==0) {
						par.seekersMap[yTile][xTile]=1;
					}
				}
				par.setSeekers();
			}
		}
		public function updateTouchText() {
			touchText.text=String(touches);
		}
		private function error() {
			trace("ERROR");
		}
	}
}