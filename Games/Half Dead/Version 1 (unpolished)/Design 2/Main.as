package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Main extends MovieClip {
		public var game:Game;
		
		public var traceFps:Boolean=false;//changeable
		public var fps;
		private var timeinit:Date=new Date;
		private var lasttime=timeinit.getMilliseconds();
		private var timepassed;
		public function Main() {
			stage.frameRate=30;
			game = new Game();
			addChild(game);
			if (traceFps) {
				addEventListener(Event.ENTER_FRAME,onLoop);
				
			}
		}
		public function onLoop(e:Event):void {
			var time:Date=new Date();
			timepassed=((time.getMilliseconds()-lasttime)>=0)?(time.getMilliseconds()-lasttime):(1000+(time.getMilliseconds()-lasttime));
			fps=Math.round(1000/timepassed);//Math.round(10000/timepassed)/10;
			lasttime=time.getMilliseconds();
			trace(fps);
		}
	}
}