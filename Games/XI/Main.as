package {
	import flash.display.MovieClip;
	public class Main extends MovieClip {
		var ts:MovieClip = new MovieClip();//titleScreen
		
		var bg:Background = new Background();
		var wave1:Wave = new Wave();
		var xi:XImask = new XImask();
		var cover:Cover = new Cover();
		
		var toBlack:ToBlack;
		public function Main() {
			ts.addChild(bg);
			ts.addChild(wave1);
			ts.addChild(xi);
			wave1.mask = xi;
			ts.addChild(cover);
			
			addChild(ts);
		}
		public function removePreloader():void {
			toBlack = new ToBlack("toMain");
			addChild(toBlack);
		}
		public function callFunct(name:String):void {
			switch(name){
				case "toMain":
					toMain();
					break;
			}
		}
		public function toMain():void {
			removeChild(ts);
		}
	}
}