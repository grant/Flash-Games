package com.arc.flixel {
	import flash.utils.getTimer;

	public class Profiler {
		private var name:String;
		private var time:Number = 0;
		
		private static const ENABLED:Boolean = false;
		
		public function Profiler(name:String, message:String = null):void {
			this.name = "[" + name + "]";
			start(message);
		}
		
		public function start(message:String = null):void {
			if (message == null) {
				message = "started";
			}
			if(ENABLED) trace("[Profiler]", name, message);
			time = getTimer();
		}
		
		public function lap(message:String = null):void {
			end(message);
			time = getTimer();
		}
		
		public function end(message:String = null):int {
			if (message == null) {
				message = "elapsed";
			}
			if (ENABLED) trace("[Profiler]", name, message, getTimer() - time + "ms");
			return getTimer() - time;
		}
	}
}
