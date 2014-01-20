package com.arc.varzea.engine {
	import com.arc.flixel.ArcGroup;
	import com.arc.flixel.message.MessageSystem;

	public class GameState extends ArcGroup {
		public var persist:Boolean = false;
		
		public function GameState() {

		}
		
		override public function update():void {
			super.update();
			MessageSystem.update();
		}
		
		override public function draw():void {
			super.draw();
			MessageSystem.draw();
		}
	}
}


