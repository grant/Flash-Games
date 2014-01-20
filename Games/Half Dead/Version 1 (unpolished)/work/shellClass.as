package {

	import flash.display.MovieClip;
	import flash.events.*;

	public class shellClass extends MovieClip {

		private var xs:int=Math.random()*15-7.5;
		private var ys:Number=Math.random()*5-7;
		private var rotationSpeed:Number=Math.random()*10+5;
		private var gravity:Number=1;
		private var friction:Number=.9;
		private var ground:Number=300+Math.random()*20;
		private var timer:uint=300;//10 seconds

		public function shellClass() {
			this.rotation=Math.random()*360;
			addEventListener(Event.ENTER_FRAME,moveShell);
		}

		private function moveShell(e:Event):void {
			this.rotation+=rotationSpeed;
			ys+=gravity*friction;
			this.x+=xs*friction;
			this.y+=ys;
			if (this.y>=ground-ys&&ys>0) {
				rotationSpeed*=.5;
				this.y=ground;
				ys=- ys*.5;
				xs*=.7;
			}
			if (timer==0) {
				if (this.alpha>0) {
					this.alpha-=.01;
				} else {
					this.removeEventListener(Event.ENTER_FRAME,moveShell);
					parent.removeChild(this);
				}
			} else {
				timer--;
			}
		}
	}
}