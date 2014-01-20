package {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	import flash.events.MouseEvent;
	
	import flash.events.Event;
	public class Selected extends MovieClip {
		private var relX:int;
		private var relY:int;
		private var par:MovieClip;
		public function Selected(xRel:int,yRel:int,wid:uint,hei:uint) {
			relX=xRel;
			relY=yRel;
			width = wid;
			height = hei;
			this.mouseEnabled=false;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			x = stage.mouseX - relX;
			y = stage.mouseY - relY;
			addEventListener(Event.ENTER_FRAME,onLoop);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onLoop(e:Event):void {
			x += (stage.mouseX-x)*par.ease;
			y += (stage.mouseY-y)*par.ease;
		}
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
			par.removeChild(this);
		}
	}
}