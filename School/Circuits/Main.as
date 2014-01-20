/*
To Do:
-Rt Algorithm

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
	public class Main extends MovieClip {
		private var tabs:Tabs;
		private var page:Page;
		public function Main():void {
			setup();
		}
		
		//sets up the stage
		private function setup():void {
			tabs = new Tabs();
			addChild(tabs);
			page = new Page(0,20);
			addChild(page);
		}
		
		//goes to a certain page
		public function toPage(pageNum:uint):void {
			page.toPage(pageNum);
		}
	}
}