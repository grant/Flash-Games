package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Sparkles extends MovieClip {
		private const sparkleRate:uint = 30;
		private const sparkleChance:Number = .5;
		private var sparkleTimer:uint=0;
		private var positions:Array = new Array;
		public function Sparkles():void {
			populatePositions();
			addEventListener(Event.ENTER_FRAME,addSparkles);
		}
		private function populatePositions():void {
			positions.push(new Array(134,32));
			positions.push(new Array(172,55));
			positions.push(new Array(209,75));
			positions.push(new Array(245,65));
			positions.push(new Array(295,55));
			positions.push(new Array(111,52));
		}
		private function addSparkles(e:Event):void {
			if(sparkleTimer==sparkleRate){
				sparkleTimer=0;
				if(Math.random()<sparkleChance){
					var position:uint = Math.floor(Math.random()*positions.length);
					var spark:Spark = new Spark(positions[position][0],positions[position][1]);
					addChild(spark);
				}
			} else {
				sparkleTimer++;
			}
		}
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,addSparkles);
			MovieClip(parent).removeChild(this);
		}
	}
}