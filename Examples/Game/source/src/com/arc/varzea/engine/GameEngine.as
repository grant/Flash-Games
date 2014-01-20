package com.arc.varzea.engine {
	import com.arc.flixel.DataSerializer;
	import com.arc.varzea.util.ParticleSystem;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.SoundSystem;
	
	import flash.ui.Mouse;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;

	public class GameEngine extends FlxState {
		private var states:Vector.<GameState>;

		public function GameEngine() {
			states = new Vector.<GameState>;
			Registry.engine = this;
		}
		
		override public function create():void {
			DataSerializer.load();
			SoundSystem.initialize();
			FlxG.camera.bgColor = 0xff77aee5;
			ParticleSystem.initialize();
			Mouse.show();
			push(new TitleState);
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("B")) {
				FlxG.visualDebug = !FlxG.visualDebug;
			}
			/*for each(var state:GameState in states) {
				state.update();
			}*/
			current.update();
			super.update();
		}
		
		override public function draw():void {
			var i:int = 0;
			for each(var state:GameState in states) {
				if (i == states.length - 1 || state.persist) {
					state.draw();
				}
			}
			super.draw();
		}
		
		public function get current():GameState {
			return states[states.length - 1];
		}

		public function push(state:GameState):void {
			states.push(state);
		}
		
		public function pop():GameState {
			return states.pop();
		}
	}
}

