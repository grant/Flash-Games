package {
	import flash.display.MovieClip;
	public class PageBackground extends MovieClip {
		private var pageName:String;
		public function PageBackground(pageName:String):void {
			this.pageName = pageName;
			gotoPage();
		}
		
		//goes to the page according to the page name
		public function gotoPage():void {
			switch(pageName) {
				case "title screen":
					gotoAndStop(1);
					break;
				case "earth page":
					gotoAndStop(2);
					break;
				case "earth play page":
					gotoAndStop(3);
					break;
				case "water page":
					gotoAndStop(4);
					break;
				case "water play page":
					gotoAndStop(5);
					break;
				case "air page":
					gotoAndStop(6);
					break;
				case "air play page":
					gotoAndStop(7);
					break;
				case "fire page":
					gotoAndStop(8);
					break;
				case "fire play page":
					gotoAndStop(9);
					break;
				case "scores":
					gotoAndStop(10);
					break;
			}
		}
		
		//sets the next page's name
		public function setNextPage(pageName:String):void {
			this.pageName = pageName;
		}
	}
}