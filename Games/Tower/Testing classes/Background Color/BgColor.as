package {
	//import foreign classes
	//import rgbcolor.RGBColor;
	//import graphic.CustomGraphic;

	//import flash classes
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.ColorTransform;

	public class BgColor extends MovieClip {
		//data//
		private var color:RGBColor;//current color
		private var prevColor:RGBColor;//previous color
		private var nextColor:RGBColor;//next color

		//trasitions//
		private var totalFrameProgress:uint=0;//frame number for transition between previous color and next color
		private var frameProgress:uint=0;//frame number progress for the transition
		private var frameProgressStart:uint=0;//the game time start of the transition

		//graphics//
		private var rect:Shape;//background
		//private var radialGradient:CustomGraphic;//white radial gradient

		public function BgColor():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			color=new RGBColor(0,165,226);//default background is blue
			nextColor = color;
			prevColor = color;
			//draws rect
			drawBg();
			//draws white gradient
			//radialGradient = new CustomGraphic("white_gradient");
			//addChild(radialGradient);
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

		/*******************
		 * Color functions *
		 *******************/
		/**
		 * setColor(RGBColor):void
		 * getColor():RGBColor
		 * updateColor():void
		 **/

		/**
		 * Sets the color of the background
		 * @param newColor The new color
		 **/
		public function setColor(newColor:RGBColor):void {
			color.setColor(newColor);
			updateColor();
		}

		/**
		 * Gets the current color of the background
		 * @return The color object
		 **/
		public function getColor():RGBColor {
			return color;
		}

		/**
		 * Updates the color of the background
		 **/
		private function updateColor():void {
			var colorChanger:ColorTransform=rect.transform.colorTransform;
			colorChanger.color=color.getHexColor();
			rect.transform.colorTransform=colorChanger;
		}

		/***************
		 * Transitions *
		 ***************/
		/**
		 * setTransition(RGBColor,frameNumber):void
		 * update():void
		 **/


		/**
		 * Sets a transition to a new color
		 * @param gameFrame The current game frame number
		 * @param nextColor The next color to transition to
		 * @param numberOfFrames The number of frames it will take to go to the next color
		 * @param (numberOfFrames == 0) ? calculate appropriate number of frames based on how close the next color is to the current color
		 **/
		public function setTransition(gameFrame:uint,nextColor:RGBColor,numberOfFrames:uint=0):void {
			if (nextColor.compareColor(this.nextColor)!=0) {// if the color is different then the destination color
				//set up previous and next colors
				prevColor=color;
				this.nextColor=nextColor;

				//reset progress
				frameProgressStart=gameFrame;
				frameProgress=0;

				//set up the time/number of frames
				if (numberOfFrames!=0) {
					totalFrameProgress=numberOfFrames;
				} else {//calculate how many frames it should take to go to the next color
					var colorCompare=color.compareColor(nextColor);//0-728
					totalFrameProgress = Math.abs(colorCompare*(.1));//0 to 72.8 frames
				}
			}
		}

		/**
		 * Updates the color
		 **/
		public function update(gameFrame:uint):void {
			//update the frame progress
			frameProgress=gameFrame-frameProgressStart;
			trace(frameProgress);

			//update current progress
			var progressRatio:Number = Math.max(1,(frameProgress/totalFrameProgress));

			color = new RGBColor(Math.abs(progressRatio*(prevColor.getRed()-nextColor.getRed()) + nextColor.getRed()), Math.abs(progressRatio*(prevColor.getGreen()-nextColor.getGreen()) + nextColor.getGreen()), Math.abs(progressRatio*(prevColor.getBlue()-nextColor.getBlue()) + nextColor.getBlue()));
			updateColor();
		}
	}
}