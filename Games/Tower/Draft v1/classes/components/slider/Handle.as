/**
 * The handle cloud for the custom slider
 **/
package components.slider {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Handle extends MovieClip {
		//constants
		private const EASE:Number = 0.8;
		//variables
		private var px:int;//very left position of the handle
		private var py:int;//y position of the handle
		private var xDes:int;
		private var sliderWidth:uint;
		private var defaultPosition:uint;//0 to 100 position on the slider
		
		private var isSelected:Boolean = false;
		//MCs
		private var par:MovieClip;
		public function Handle(px:int,py:int,sliderWidth:uint,defaultPosition:uint=50):void {
			this.px = px;
			this.py = py;
			this.sliderWidth = sliderWidth;
			this.defaultPosition = defaultPosition;
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			setPosition();
			addEventListener(Event.ENTER_FRAME,onLoop,false,0,true);
			addEventListener(MouseEvent.MOUSE_DOWN,mouseIsDown,false,0,true);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseIsUp,false,0,true);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		/**
		 * Sets the initial position of the slider handle
		 **/
		private function setPosition():void {
			x = px+(sliderWidth*0.01)*defaultPosition;
			y = py;
			xDes = x;
		}
		
		/**
		 * Updates the handler's position
		 **/
		private function onLoop(e:Event):void {
			if(isSelected) {
				//updated destination position
				xDes = par.mouseX-(this.width*0.5);
			}
			x += (xDes-x)*EASE;
			if(x>(px+sliderWidth)) {//if beyond max position
				x = px+sliderWidth;
			} else if(x<px) {//if before the min position
				x = px;
			}
		}
		
		/**
		 * Sets the holder as selected
		 **/
		private function mouseIsDown(e:MouseEvent):void {
			isSelected = true;
		}
		/**
		 * Sets the holder as unselected
		 **/
		private function mouseIsUp(e:MouseEvent):void {
			isSelected = false;
		}
		
	}
}