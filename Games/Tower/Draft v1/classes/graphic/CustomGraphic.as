/**
 * Stores a lot of regular graphics
 **/
package graphic {
	import flash.display.MovieClip;
	public class CustomGraphic extends MovieClip {
		public function CustomGraphic(idName:String):void {
			//find the frame number of the graphic
			switch(idName) {
				case "white_gradient":
				 	gotoAndStop(1);
					break;
				case "back_clouds":
				    gotoAndStop(2);
					break;
				case "middle_clouds":
					gotoAndStop(3);
					break;
				case "front_clouds":
					gotoAndStop(4);
					break;
				case "lock":
					gotoAndStop(5);
					break;
			}
		}
	}
}