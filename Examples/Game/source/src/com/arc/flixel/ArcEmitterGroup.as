package com.arc.flixel {
	public class ArcEmitterGroup extends ArcGroup {
		public function ArcEmitterGroup(X:Number = 0, Y:Number = 0) {
			super();
			x = X;
			y = Y;
		}
		
		override public function destroy():void {
			return;
		}
	}
}
