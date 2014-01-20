/**
 * A Color object that can store a color value
 **/
package rgbcolor {
	public class RGBColor extends Object {
		private var red:uint;
		private var green:uint;
		private var blue:uint;
		public function RGBColor(red:uint,green:uint,blue:uint):void {
			this.red = red;
			this.green = green;
			this.blue = blue
		}
		
		//Set methods
		
		/**
		 * Sets the color
		 * @param color The new color
		 **/
		public function setColor(newColor:RGBColor):void {
			this.red = newColor.getRed();
			this.green = newColor.getGreen();
			this.blue = newColor.getBlue();
		}
		
		/**
		 * Sets the color
		 * @param r Red
		 * @param g Green
		 * @param b Blue
		 **/
		public function setRGBColor(r:uint,green:uint,blue:uint):void {
			this.red = red;
			this.green = green;
			this.blue = blue;
		}
		
		//Get methods
		
		/**
		 * Gets colors as a number
		 * @return The color as a number
		 **/
		public function getRed():uint {
			return red;
		}
		public function getGreen():uint {
			return green;
		}
		public function getBlue():uint {
			return blue;
		}
		
		/**
		 * Gets the hex color as a number
		 * @return The hex number as a number
		 **/
		public function getHexColor():uint {
			return (red << 16) + (green << 8) + blue;
		}
	}
}