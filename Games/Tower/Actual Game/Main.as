package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Main extends MovieClip {
		public function Main():void {
			//addEventListener(Event.ADDED_TO_STAGE,onAdd);
			var game:Game = new Game();
			addChild(game);
		}
		private function onAdd(e:Event):void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onMove(e:MouseEvent):void {
			for (var a:uint =0; a<10; a++) {
				//var spark:Sparks=new Sparks(stage.mouseX,stage.mouseY);
				//addChild(spark);
			}
		}
	}
}