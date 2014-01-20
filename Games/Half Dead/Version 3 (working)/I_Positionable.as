//Can be given an x and y position
package {
	public interface I_Positionable {
		function getX():Number;
		function getY():Number;
		function getPosition():Array;
		
		function setX(px:Number):void;
		function setY(py:Number):void;
		function setPosition(position:Array):void;
	}
}