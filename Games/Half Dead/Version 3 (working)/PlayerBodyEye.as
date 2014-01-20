//The player body's eye
//par:PlayerBody
//children:none
package {
	import flash.display.MovieClip;
	public class PlayerBodyEye extends MovieClip implements I_Positionable, I_Typeable {
		//constants
		const DEFAULT_TYPE:uint = 0;
		var POSITIONS:Array;//hash map (index:frame #,data:Array(x,y))
		//properties
		var type:uint;
		public function PlayerBodyEye():void {
			setup();
			setType(DEFAULT_TYPE);
		}
		
		//setup
		private function setup():void {
			POSITIONS = new Array();
			POSITIONS[0] = new Array(10,-60);
			POSITIONS[1] = new Array(45,-60);
		}
		
		////I_Positionable
		
		////Getters
		//Gets the X position of the object
		public function getX():Number {
			return x;
		}
		//Gets the y position of the object
		public function getY():Number {
			return y;
		}
		//Gets the position of the object in array form
		public function getPosition():Array {
			return new Array(x,y);
		}
		
		////Setters
		//Sets the X position of the object
		public function setX(px:Number):void {
			x = px;
		}
		//Sets the Y position of the object
		public function setY(py:Number):void {
			y = py;
		}
		//Sets the position of the object using an array
		public function setPosition(position:Array):void {
			x = position[0];
			y = position[1];
		}
		
		////I_Typeable
		//Gets the type
		public function getType():uint {
			return type;
		}
		
		//Sets the type
		public function setType(type:uint):void {
			this.type = type;
			gotoAndStop(type+1);
			setPosition(POSITIONS[type]);
		}
	}
}