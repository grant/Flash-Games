package background {
	//import foreign classes
	import rgbcolor.RGBColor;
	import graphic.CustomGraphic;
	
	//import flash classes
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	
	public class BgColor extends MovieClip {
		//data
		private var color:RGBColor;//color object
		//graphics
		private var rect:Shape;//background
		private var radialGradient:CustomGraphic;//white radial gradient
		public function BgColor():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			color = new RGBColor(0,165,226);//default background is blue
			//draws rect
			drawBg();
			//draws white gradient
			radialGradient = new CustomGraphic("white_gradient");
			addChild(radialGradient);
		}
		
		/**
		 * Draws the background
		 **/
		private function drawBg():void {
			rect = new Shape();
			rect.graphics.beginFill(color.getHexColor());
			rect.graphics.drawRect(0,0,stage.stageWidth,stage.stageHeight);
			rect.graphics.endFill();
			addChild(rect);
		}
		
		/**
		 * Sets the color of the background
		 * @param newColor The new color
		 **/
		public function setColor(newColor:RGBColor):void {
			color.setColor(newColor);
			updateColor();
		}
		
		/**
		 * Gets the color of the background
		 * @return The color object
		 **/
		public function getColor():RGBColor {
			return color;
		}
		
		/**
		 * Updates the color of the background
		 **/
		private function updateColor():void {
			var colorChanger:ColorTransform = rect.transform.colorTransform;
			colorChanger.color = color.getHexColor();
			rect.transform.colorTransform = colorChanger;
		}
	}
}