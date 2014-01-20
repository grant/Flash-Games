//The viewable game
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	public class Game extends MovieClip {
		//keyboard
		public var KEYBOARD:CustomKeyboard;
		//objects
		public var WORLD_VIEWER:WorldViewer;
		//variables
		public var BUG_GRAVITY:Number = 1.5;
		
		public function Game():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			setup();
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//sets up the game
		private function setup():void {
			WORLD_VIEWER = new WorldViewer();
			addChild(WORLD_VIEWER);
			
			//keyboard
			KEYBOARD = new CustomKeyboard();
			addChild(KEYBOARD);
			
			//WORLD_VIEWER.centerCameraTo(0,0);
			//WORLD_VIEWER.easeMoveCameraTo(100,0);
		}
		
		//
		//Events
		//
		
		//Keyboard Events
		//key down
		private function keyIsDown(e:KeyboardEvent):void {
			
		}
		//key up
		private function keyIsUp(e:KeyboardEvent):void {
			
		}
	}
}