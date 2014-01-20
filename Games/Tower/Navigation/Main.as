package {
	import flash.display.MovieClip;
	public class Main extends MovieClip {
		public var h:Array = new Array();//button holder
		public var nav:Nav = new Nav(1,1);
		public function Main():void {
			setButtons();
			addButtons();
			addNav();
		}
		private function setButtons():void {
			//Comments are: (row)(column)
			
			h.push(new Btn(0,-155,0,0,280,50));//1,1
			
			h.push(new Btn(0,-85,0,0,280,50));//2,1
			
			h.push(new Btn(-120,-20,0,0,40,40));//3,1
			h.push(new Btn(-120,40,0,0,40,40));//4,1
			h.push(new Btn(-120,100,0,0,40,40));//5,1
			
			h.push(new Btn(-60,-20,0,0,40,40));//3,2
			h.push(new Btn(-60,40,0,0,40,40));//4,2
			h.push(new Btn(-60,100,0,0,40,40));//5,2
			
			h.push(new Btn(0,-20,0,0,40,40));//3,3
			h.push(new Btn(0,40,0,0,40,40));//4,3
			h.push(new Btn(0,100,0,0,40,40));//5,3
			
			h.push(new Btn(60,-20,0,0,40,40));//3,4
			h.push(new Btn(60,40,0,0,40,40));//4,4
			h.push(new Btn(60,100,0,0,40,40));//5,4
			
			h.push(new Btn(120,-20,0,0,40,40));//3,5
			h.push(new Btn(120,40,0,0,40,40));//4,5
			h.push(new Btn(120,100,0,0,40,40));//5,5
			
			h.push(new Btn(-75,160,0,0,130,40));//6,1
			h.push(new Btn(75,160,0,0,130,40));//6,2
			
		}
		private function addButtons():void {
			for(var a:uint = 0;a<h.length;a++){
				nav.addChild(h[a]);
			}
		}
		private function addNav():void {
			addChild(nav);
		}
	}
}