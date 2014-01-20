package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Start extends MovieClip {
		private var par:MovieClip;
		public function Start(xPos:uint,yPos:uint,wid:uint,hei:uint) {
			x = xPos;
			y = yPos;
			width = wid;
			height = hei;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(MouseEvent.CLICK,onClick);
		}
		private function onAdd(e:Event) {
			par = MovieClip(parent);
		}
		private function onClick(e:MouseEvent):void {
			var anySeekers:Boolean = false;
			for(var a=0;a<par.seekersMap[0].length;a++){
				for(var b=0;b<par.seekersMap.length;b++){
					if(par.seekersMap[b][a]!=0){
						anySeekers=true;
					}
				}
			}
			if(anySeekers){
				par.startSeekers();
			}
		}
	}
}