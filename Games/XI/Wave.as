package {
	import flash.display.MovieClip;
	import flash.events.ProgressEvent;
	import flash.display.Loader;
	import flash.events.Event;
	public class Wave extends MovieClip {
		var loader:Loader = new Loader();
		var total:uint=1;
		var loaded:uint=0;
		var target:Number=0;
		var removing:Boolean=false;
		public function Wave() {
			x=0;
			y=400;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			addEventListener(Event.ENTER_FRAME,onLoop);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onLoop(e:Event):void {
			if (y<=30) { //remove everything
				if(removing==false){
					removing = true;
					//Main.as
					MovieClip(parent.parent).removePreloader();
				}
			} else { //hasn't loaded yet
				//update loaded data info
				total=stage.loaderInfo.bytesTotal;
				loaded=stage.loaderInfo.bytesLoaded;
				target = Math.abs(((loaded/total)*400)-400);
				y -= (y-target)*.02;
				x+=10;
				if (x>=stage.stageWidth) {
					x=0;
				}
			}
		}
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
			parent.removeChild(this);
		}
	}
}