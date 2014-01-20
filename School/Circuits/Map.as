//par:DisplayMap
package {
	import flash.display.MovieClip;
	public class Map extends MovieClip {
		private var defaultMaps:Array;
		
		private var wid:uint = 0;
		private var hei:uint = 0;
		private var circuit:Array;
		//legend:
		//0 - none
		//1 - wire
		//2 - resistor
		//4 - battery
		private var algorithms:MapAlgorithms;
		public function Map(wid:uint,hei:uint):void {
			this.wid = wid;
			this.hei = hei;
			setDefaultMaps();
			initiate();
		}
		
		//sets default maps up
		private function setDefaultMaps():void {
			defaultMaps = new Array();
			
			defaultMaps[0] = new Array();
			defaultMaps[0][0] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][1] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][2] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][3] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][4] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][5] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][6] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][7] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][8] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][9] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][10] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[0][11] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			
			defaultMaps[1] = new Array();
			defaultMaps[1][0] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[1][1] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[1][2] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[1][3] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[1][4] = new Array(0,0,2,2,2,2,2,2,2,2,0,0);
			defaultMaps[1][5] = new Array(0,0,4.34,0,0,1.6,0,1.8,0,1.10,0,0);
			defaultMaps[1][6] = new Array(0,0,2,0,0,2,0,2,2,2,0,0);
			defaultMaps[1][7] = new Array(0,0,2,2,2,2,2,2,0,0,0,0);
			defaultMaps[1][8] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[1][9] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[1][10] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
			defaultMaps[1][11] = new Array(0,0,0,0,0,0,0,0,0,0,0,0);
		}
		
		//creates the circuit map
		private function initiate():void {
			circuit = defaultMaps[1];
			/*
			circuit = new Array();
			for(var i:uint = 0;i<hei;i++) {
				circuit[i] = new Array();
				for(var j:uint = 0;j<wid;j++) {
					circuit[i][j] = 0;
				}
			}
			*/
			
			algorithms = new MapAlgorithms(wid,hei);
			addChild(algorithms);
		}
		
		//removes the element from the map
		public function removeElement(px:uint,py:uint) {
			if(inBounds(px,py)) {
				setElement(px,py,0);
			}
		}
		
		//creates a wire at the specified point
		public function addWire(px:uint,py:uint) {
			if(inBounds(px,py)) {
				setElement(px,py,1);
			}
		}
		
		//adds a resistor at a specific point and resistance
		public function addResistor(px:uint,py:uint,resistance:Number) {
			if(inBounds(px,py)) {
				var r:String = String(resistance);
				setElement(px,py,int("2."+r));
			}
		}
		
		//gets the circuit
		public function getCircuit():Array {
			return circuit;
		}
		
		//checks if the point is inside the defined map
		public function inBounds(px:uint,py:uint):Boolean {
			return (px<wid&&py<hei);
		}
		
		//sets the element a certain number
		private function setElement(px:uint,py:uint,number:uint):void {
			circuit[py][px] = number;
		}
		
		//gets the element's number (string)
		public function getElement(px:uint,py:uint):String {
			return circuit[py][px];
		}
		
		//gets the element's number of directions
		public function getNumDirections(px:uint,py:uint):uint {
			var num:uint = 0;
			num += hasLeft(px,py)?1:0;
			num += hasRight(px,py)?1:0;
			num += hasTop(px,py)?1:0;
			num += hasBottom(px,py)?1:0;
			return num;
		}
		
		//gets the map
		public function getMap():Array {
			return circuit;
		}
		
		//if the element has an element to the left
		public function hasLeft(px:uint,py:uint):Boolean {
			return (px>0)&&(circuit[py][px-1]!=0);
		}
		//if the element has an element to the right
		public function hasRight(px:uint,py:uint):Boolean {
			return (px<wid)&&(circuit[py][px+1]!=0);
		}
		//if the element has an element to the top
		public function hasTop(px:uint,py:uint):Boolean {
			return (py>0)&&(circuit[py-1][px]!=0);
		}
		//if the element has an element to the bottom
		public function hasBottom(px:uint,py:uint):Boolean {
			return (py<hei-1)&&(circuit[py+1][px]!=0);
		}
		//if the element has an element in the specified direction
		public function hasDirection(px:uint,py:uint,dir:uint):Boolean {
			var okay:Boolean = false;
			switch(dir) {//[0] = top,[1] = right,[2] = bottom,[3] = left
				case 0:
					okay = hasTop(px,py);
					break;
				case 1:
					okay = hasRight(px,py);
					break;
				case 2:
					okay = hasBottom(px,py);
					break;
				case 3:
					okay = hasLeft(px,py);
					break;
			}
			return okay;
		}
	}
}