package {
	import com.arc.varzea.engine.GameEngine;
	import org.flixel.FlxGame;
	
	[SWF(width = "720", height = "480", backgroundColor = "#ffffff")]
	[Frame(factoryClass = "Preloader")]
	
	public class Arzea extends FlxGame {
		public function Arzea() {
			super(360, 240, GameEngine, 2, 60, 60, true);
			//forceDebugger = true;
		}
	}
}