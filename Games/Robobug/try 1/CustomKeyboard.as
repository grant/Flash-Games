//deals with keyboard functions
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	public class CustomKeyboard extends MovieClip {
		//debug
		private const DEBUG_MODE:Boolean = false;
		//arrow keys
		public var DOWN:Boolean = false;
		public var UP:Boolean = false;
		public var LEFT:Boolean = false;
		public var RIGHT:Boolean = false;
		//
		public function CustomKeyboard():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			setup();
		}
		
		//sets up the custom keyboard
		private function setup():void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyIsDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,keyIsUp);
		}
		
		//when a key is down
		private function keyIsDown(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37: LEFT=true; break;
				case 38: UP=true; break;
				case 39: RIGHT=true; break;
				case 40: DOWN=true; break;
			}
			if(DEBUG_MODE) {
				trace("Keycode: "+e.keyCode+" is down.");
			}
		}
		
		//when a key is up
		private function keyIsUp(e:KeyboardEvent):void {
			switch(e.keyCode) {
				case 37: LEFT=false; break;
				case 38: UP=false; break;
				case 39: RIGHT=false; break;
				case 40: DOWN=false; break;
			}
			if(DEBUG_MODE) {
				trace("Keycode: "+e.keyCode+" is up.");
			}
		}
	}
}