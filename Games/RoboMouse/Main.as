//Ideas:

//1: RoboMouse is Title
//2: User able to create maps
//3: Campaing (16 lvls) able to place robomouse and a few walls
//4: Scores for:
//    Lowest number of moves
//    Highest number of moves
//    Least Deaths
//5: Bonus: try to get only 1 of 2 mice
//6: Use lots of mice in last level
//7: Map editor
//8: Different Colors of mice for each level
//9: Basic image awards (faster speed)
//10: Disable Numbers
//11: Tiles get darker or follow a rainbow pattern the more times they are touched
//12: Awards for every new color you find (from larger tile numbers)
//13: Modes:
//     Campaign (16 lvls)
//     Sandbox
//     Endless (Try for longest time
//14: Tile conveyor belt


//Ideas for series game:
//8: Conveyor belt tile (4 directions)
//9: Bomb Tile(Try to protect your mice)
//10: Water Tile(Mouse falls in and makes a bridge)
//11: Telemouse? (Mouse travels 2 squares)
//12: Ice Tile (can only be hit a certain number of times
//13: Create depth (Mice can only fall or go up ramps, can't go up sides)
//14: Objective: Have least number of mice die
//15: Slide Tile: Once mice turn, they can only go that way until they hit a wall
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Main extends MovieClip {
		public var row:uint;
		public var col:uint;
		public var xOff:uint=50;
		public var yOff:uint=10;
		public var wid:uint=30;
		public var hei:uint=30;

		public var settingMap:Boolean=true;
		public var selectedTile:uint=1;

		public var numDisabled:Boolean=false;

		public function Main() {
			setup();
			setMap();
			//removeMap();
			setSeekers();
		}
		public var map:Array;
		public var seekersMap:Array;
		public var walkable:Array;
		public var textVisible:Array;
		private function setup():void {
			walkable = [1,0,1];
			textVisible = [1,0,1];
			map = new Array();
			map[0]=[2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
			map[1]=[2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
			map[2]=[2,1,1,3,3,2,2,2,2,2,2,2,2,2,2,2,2];
			map[3]=[2,1,3,3,3,3,3,3,2,2,2,2,2,2,2,2,2];
			map[4]=[2,1,1,2,2,3,3,3,2,2,2,2,2,2,2,2,2];
			map[5]=[2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
			map[6]=[2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
			map[7]=[2,1,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2];
			map[8]=[2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
			map[9]=[2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2];
			row=map[0].length;
			col=map.length;
			seekersMap = new Array();
			seekersMap[0]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[1]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[2]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[3]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[4]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[5]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[6]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[7]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[8]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			seekersMap[9]=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
			var ground:TileSelect=new TileSelect(1,10,10,wid,hei);
			addChild(ground);
			var wall:TileSelect=new TileSelect(2,10,10+hei+10,wid,hei);
			addChild(wall);
			var oil:TileSelect=new TileSelect(4,10,30+2*hei,wid,hei);
			addChild(oil);
			var mouse:TileSelect=new TileSelect(3,10,40+3*hei,wid,hei);
			addChild(mouse);
			var start:Start=new Start(10,50+4*hei,wid,hei);
			addChild(start);
			var disableNum:DisableNumbers= new DisableNumbers(10,60+5*hei,wid,hei);
			addChild(disableNum);
		}
		public var tiles:Array;
		public function setMap():void {
			tiles = new Array();
			for (var a=0; a<row; a++) {
				tiles[a] = new Array();
				for (var b=0; b<col; b++) {
					//xOff+(a*wid),yOff+(b*hei)
					//frame#,tileX,tileY,wid,hei
					var tile:Tile=new Tile(map[b][a],a,b,wid,hei);
					tiles[a][b]=tile;
					addChild(tiles[a][b]);
				}
			}
		}
		public function removeMap() {
			for (var a=0; a<tiles.length; a++) {
				for (var b=0; b<tiles[0].length; b++) {
					removeChild(tiles[b][a]);
				}
			}
			tiles=null;
		}
		public function resetTiles():void {
			for (var a=0; a<tiles.length; a++) {
				for (var b=0; b<tiles[0].length; b++) {
					tiles[a][b].touches=0;
					//prev b,a
					tiles[a][b].updateTouchText();
					//prev b,a
				}
			}
		}
		public function addTile(a:uint,b:uint):void {
			var tile:Tile=new Tile(map[b][a],a,b,wid,hei);
			tiles[a][b]=tile;
			addChild(tiles[a][b]);
		}
		public var seekers:Array;
		public function setSeekers():void {
			seekers = new Array();
			for (var a=0; a<seekersMap[0].length; a++) {
				seekers[a] = new Array();
				for (var b=0; b<seekersMap.length; b++) {
					if (seekersMap[b][a]!=0) {
						seekers[a][b]=new Seeker(a,b,wid,hei*(4/3));
						addChild(seekers[a][b]);
					}
				}
			}
		}
		public function startSeekers():void {
			if (settingMap) {
				settingMap=false;
				for (var a=0; a<seekersMap[0].length; a++) {
					for (var b=0; b<seekersMap.length; b++) {
						if (seekersMap[b][a]!=0) {
							seekers[a][b].startMove();
							tiles[a][b].touches++;
							tiles[a][b].updateTouchText();
						}
					}
				}
			} else {
				removeSeekers();
				resetTiles();
				setSeekers();
			}
		}
		public function removeSeekers():void {
			settingMap=true;
			for (var a=0; a<seekersMap[0].length; a++) {
				for (var b=0; b<seekersMap.length; b++) {
					if (seekersMap[b][a]!=0) {
						//prev: a,b
						seekers[a][b].remove();
					}
				}
			}
		}
	}
}