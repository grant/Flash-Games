package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class DisableNumbers extends Sprite {
		private var par:MovieClip;
		public function DisableNumbers(xPos:uint,yPos:uint,wid:uint,hei:uint) {
			x = xPos;
			y = yPos;
			width = wid;
			height = hei;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onClick(e:MouseEvent):void {
			for (var a=0; a<par.row; a++) {
				for (var b=0; b<par.col; b++) {
					if(par.textVisible[par.map[b][a]-1]==1){
						if(par.tiles[a][b].touchText.visible){
							par.tiles[a][b].touchText.visible=false;
							par.numDisabled=true;
						} else {
							par.tiles[a][b].touchText.visible=true;
							par.numDisabled=false;
						}
					}
				}
			}
		}
	}
}
