//par:Map
/*
/////////////
Rt Algorithm:
/////////////
1. Simplify map to the following only:
	-Battery
	-Resistors
	-Joints

START (recurse) (test PER JOINT)
1. If one resistor left in algorithm
	-GOTO END
2. If 2 resistors are in series (no joint between 2 resistors)
	-Combine resistors in algorithm
	-Go to START
3. If a joint splits in 2 or 3, has one resistor between each line, and ends at the same point (basic parallel)
	-if split 3, then also check split 2 for each 3 combination
	-Go to START
	
END
1. Final Resistance is the last resistor

////////////////
End Rt Algorithm
////////////////

Programming Implimentation:

- Create array of joint points (2 pts)
- Create array of segments (4 pts) and resistor (can be 0)
	-Automatically add up resistors if 2+ on same segment
- Start from battery
*/
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class MapAlgorithms extends MovieClip {
		//legend:
		//0 - none
		//2 - wire
		//1 - resistor
		//4 - battery
		//constructor
		private var wid:uint;
		private var hei:uint;
		//variables
		private var joints:Array;//3+ directions [0] = x, [1] = y
		private var segments:Array;//[0] = joint1, [1] = joint2, [2] resistance, [3] hasBattery (Boolean)
		private var resistors:Array;//[0] = x, [1] = y, [2] = resistance
		private var battery:Array;//only 1 [0] = x, [1] = y
		private var voltage:Number;//current battery voltage
		
		private var par:MovieClip;
		public function MapAlgorithms(wid:uint,hei:uint):void {
			this.wid = wid;
			this.hei = hei;
			addEventListener(Event.ADDED,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			setUp();
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//sets up some of the constant variables
		private function setUp():void {
			setUpBattery();
			setUpJoints();
			setUpResistors();
			setUpSegments();
		}
		
		//sets up the battery
		private function setUpBattery():void {
			var a:Array = new Array(-1,-1);
			for(var i:uint = 0;i<hei;i++) {//y
				for(var j:uint = 0;j<wid;j++) {//x
					if(toTileNum(par.getMap()[i][j])==4) {//battery
						a[0] = j;
						a[1] = i;
						voltage = toTextNum(par.getMap()[i][j]);
					}
				}
			}
			battery = a;
		}
		
		//sets up an array of the joints (3+ directional points)
		private function setUpJoints():void {
			joints = new Array();
			for(var i:uint = 0;i<hei;i++) {//y
				for(var j:uint = 0;j<wid;j++) {//x
					var numDirections = par.getNumDirections(j,i);
					if(numDirections>=3&&exists(j,i)) {
						joints.push(new Array(j,i));
					}
				}
			}
		}
		
		//sets up the resistors
		private function setUpResistors():void {
			resistors = new Array();
			for(var i:uint = 0;i<hei;i++) {//y
				for(var j:uint = 0;j<wid;j++) {//x
					if(toTileNum(par.getMap()[i][j])==1) {//is resistor
						resistors.push(new Array(j,i,toTextNum(par.getMap()[i][j])));
					}
				}
			}
		}
		
		//sets up all the segments
		private function setUpSegments():void {
			segments = new Array();
			//for all joints
			//for all directions
			for(var j:uint = 0;j<joints.length;++j) {//choose a joint
				var px:uint = joints[j][0];
				var py:uint = joints[j][1];
				
				var directionIteration:uint = 0;//current direction [0] = top,[1] = right,[2] = bottom,[3] = left
				var directionsLeft:uint = par.getNumDirections(px,py);
				while(directionsLeft>0) {//still need to travel a direction to add a segment (according to num directions)
					var goodDirection:Boolean;//joint has connection this way or not (based on directionIteration)
					switch(directionIteration) {
						case 0://top
							goodDirection = par.hasTop(px,py);
							break;
						case 1://right
							goodDirection = par.hasRight(px,py);
							break;
						case 2://bottom
							goodDirection = par.hasBottom(px,py);
							break;
						case 3://left
							goodDirection = par.hasLeft(px,py);
							break;
					}
					if(goodDirection) {//(has[Direction]) travel on path
						//start segment
						var resistance:Number = 0;
						var hasBattery:Boolean = false;
						var cx:uint = px;//current x
						var cy:uint = py;//current y
						//FIX
						var lastDirection:uint = directionIteration;//[0] = top,[1] = right,[2] = bottom,[3] = left
						var displacement:Array = getDisplacement(directionIteration);
						cx += displacement[0];
						cy += displacement[1];
						//FIX
						while(!isJoint(cx,cy)) {//travel on path while not arrived at a joint
							//if not joint, then what?
							if(isResistor(cx,cy)) {//resistor
								resistance += getResistance(cx,cy);
							} else if(isBattery(cx,cy)) {
								hasBattery = true;
							}//else wire (do nothing)
							//continue
							var nextDirection:uint = getOtherDirection(cx,cy,lastDirection);//[0] = top,[1] = right,[2] = bottom,[3] = left
							displacement = getDisplacement(nextDirection);//new relative displacement to new direction
							cx += displacement[0];
							cy += displacement[1];
						}
						//arrived at a resistor at cx,cy
						//if(noSegmentOf(new Array(px,py),new Array(cx,cy))) {
							segments.push(new Array(new Array(px,py),new Array(cx,cy),resistance,hasBattery));
						//}
						//END
						--directionsLeft;
					}
					//END
					++directionIteration;
				}
			}
		}
		
		//checks if the tile exists or not
		private function exists(px:uint,py:uint):Boolean {
			return (par.getMap()[py][px]!=0);
		}
		
		//checks if the tile is a joint or not
		private function isJoint(px:uint,py:uint):Boolean {
			var isyes:Boolean = false;
			for(var i:uint = 0;i<joints.length;++i) {
				if(joints[i][0]==px&&joints[i][1]==py) {
					isyes=true;
				}
			}
			return isyes;
		}
		
		//checks if the tile is a resistor or not
		private function isResistor(px:uint,py:uint):Boolean {
			return (par.getMap()[py][px]==2);
		}
		//gets the resistance of the element (must have resistor)
		private function getResistance(px:uint,py:uint):Number {
			return toTextNum(par.getMap()[py][px]);
		}
		
		//checks if the tile is a battery or not
		private function isBattery(px:uint,py:uint):Boolean {
			return (par.getMap()[py][px]==4);
		}
		
		//gets the opposite direction (hash)
		private function getOppositeDirection(dir:uint):uint {
			return (dir+2)%4;//[0] = top,[1] = right,[2] = bottom,[3] = left
		}
		
		//gets a different direction than a specified direction for a specified tile
		private function getOtherDirection(px:uint,py:uint,dir:uint):int {
			var newDir:int = -1;
			for(var i:uint = 0;i<4;++i) {
				if(i!=dir) {
					if(par.hasDirection(px,py,i)) {
						newDir = i;
					}
				}
			}
			return newDir;
		}
		
		//gets the direction displacement (based on circuit array)
		//return: new Array(x displacement,y displacement)
		private function getDisplacement(dir:uint):Array {
			var a:Array;
			switch(dir) {//[0] = top,[1] = right,[2] = bottom,[3] = left
				case 0:
					a = new Array(0,-1);
					break;
				case 1:
					a = new Array(1,0);
					break;
				case 2:
					a = new Array(0,1);
					break;
				case 3:
					a = new Array(-1,0);
					break;
			}
			return a;
		}
		
		//checks if there is no segment of the two coordinates
		private function noSegmentOf(pos1:Array,pos2:Array):Boolean {
			var hasNone:Boolean = true;
			for(var i:uint = 0;i<segments.length;i++) {
				if(segments[i][0][0]==pos1[0]&&segments[i][0][1]==pos1[1]) {//same pos1
					if(segments[i][1][0]==pos2[0]&&segments[i][1][1]==pos2[1]) {//same as pos2
						hasNone = false;
					}
				} else if(segments[i][1][0]==pos1[0]&&segments[i][1][1]==pos1[1]) {//switched pos same
					if(segments[i][0][0]==pos2[0]&&segments[i][0][1]==pos2[1]) {//switched pos same
						hasNone = false;
					}
				}
			}
			return hasNone;
		}
		
		//turns the element number into a tile num
		private function toTileNum(str:String):uint {
			return uint(str.substring(0,1));
		}
		
		//turns the element number into text num
		private function toTextNum(str:String):Number {
			return Number(str.substring(2));
		}
		
		//if the element has an element to the left
		public function hasLeft(px:uint,py:uint):Boolean {
			return (px>0)&&(par.getMap()[py][px-1]!=0);
		}
		//if the element has an element to the right
		public function hasRight(px:uint,py:uint):Boolean {
			return (px<wid)&&(par.getMap()[py][px+1]!=0);
		}
		//if the element has an element to the top
		public function hasTop(px:uint,py:uint):Boolean {
			return (py>0)&&(par.getMap()[py-1][px]!=0);
		}
		//if the element has an element to the bottom
		public function hasBottom(px:uint,py:uint):Boolean {
			return (py<hei-1)&&(par.getMap()[py+1][px]!=0);
		}
	}
}