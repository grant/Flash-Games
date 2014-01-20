package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Seeker extends MovieClip {

		public var xTile:uint;
		public var yTile:uint;
		private var wid:uint;
		private var hei:uint;

		private var speed:Number=.1;//0 to 1
		private var xs:Number;
		private var ys:Number;
		private var mouseCollision:Boolean=false;

		public var par:MovieClip;
		public function Seeker(tileX:uint,tileY:uint,w:uint,h:uint) {

			xTile=tileX;
			yTile=tileY;
			wid=w;
			hei=h;

			stop();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {

			leastTouches = new Array();
			par=MovieClip(parent);
			mouseEnabled=false;//makes it so it can't be clicked
			width=wid;
			height=hei;
			x=par.tiles[xTile][yTile].x;
			y=par.tiles[xTile][yTile].y;

			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private var leastTouches:Array;

		private var tileUp:Boolean=true;
		private var tileDown:Boolean=true;
		private var tileLeft:Boolean=true;
		private var tileRight:Boolean=true;

		private var downTouch:int=0;
		private var leftTouch:int=0;
		private var rightTouch:int=0;
		private var upTouch:int=0;
		
		private var lastDirection:String;

		public function startMove():void {
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			moveSeeker();
		}
		private function moveSeeker():void {
			if (x==par.tiles[xTile][yTile].x&&y==par.tiles[xTile][yTile].y) {
				tileUp=false;
				tileDown=false;
				tileLeft=false;
				tileRight=false;
				if (yTile!=0) {//not on very top
					if (par.walkable[par.tiles[xTile][yTile-1].currentFrame-1]==1) {//tile above is good
						tileUp=true;
						if (mouseCollision) {
							for (var a=0; a<par.seekersMap[0].length; a++) {
								for (var b=0; b<par.seekersMap.length; b++) {
									if (par.seekersMap[a][b]!=0) {//if a mouse is there
										if (par.seekers[b][a]!=this) {//if mouse isn't self
											if (par.seekers[b][a].yTile==yTile-1) {//if this mouse on destination xTile
												if (par.seekers[b][a].xTile==xTile) {//if this mouse on destination yTile
													tileUp=false;
												}
											}
										}
									}
								}
							}
						}
					}
				}
				if (yTile!=par.col-1) {//not on very bottom
					if (par.walkable[par.tiles[xTile][yTile+1].currentFrame-1]==1) {//tile above is good
						tileDown=true;
						if (mouseCollision) {
							for (var c=0; c<par.seekersMap[0].length; c++) {
								for (var d=0; d<par.seekersMap.length; d++) {
									if (par.seekersMap[c][d]!=0) {//if a mouse is there
										if (par.seekers[d][c]!=this) {//if mouse isn't self
											if (par.seekers[d][c].yTile==yTile+1) {//if this mouse on destination xTile
												if (par.seekers[d][c].xTile==xTile) {//if this mouse on destination yTile
													tileDown=false;
												}
											}
										}
									}
								}
							}
						}
					}
				}
				if (xTile!=0) {//not on very left
					if (par.walkable[par.tiles[xTile-1][yTile].currentFrame-1]==1) {//tile above is good
						tileLeft=true;
						if (mouseCollision) {
							for (var e=0; e<par.seekersMap[0].length; e++) {
								for (var f=0; f<par.seekersMap.length; f++) {
									if (par.seekersMap[e][f]!=0) {//if a mouse is there
										if (par.seekers[f][e]!=this) {//if mouse isn't self
											if (par.seekers[f][e].xTile==xTile-1) {//if this mouse on destination xTile
												if (par.seekers[f][e].yTile==yTile) {//if this mouse on destination yTile
													tileLeft=false;
												}
											}
										}
									}
								}
							}
						}
					}
				}
				if (xTile!=par.row-1) {//not on very right
					if (par.walkable[par.tiles[xTile+1][yTile].currentFrame-1]==1) {//tile above is good
						tileRight=true;
						if (mouseCollision) {
							for (var h=0; h<par.seekersMap[0].length; h++) {
								for (var i=0; i<par.seekersMap.length; i++) {
									if (par.seekersMap[h][i]!=0) {//if a mouse is there
										if (par.seekers[i][h]!=this) {//if mouse isn't self
											if (par.seekers[i][h].xTile==xTile+1) {//if this mouse on destination xTile
												if (par.seekers[i][h].yTile==yTile) {//if this mouse on destination yTile
													tileLeft=false;
												}
											}
										}
									}
								}
							}
						}
					}
				}
				//down,left,right,up
				if (tileDown) {
					downTouch=par.tiles[xTile][yTile+1].touches;
				} else {
					downTouch=-1;
				}
				if (tileLeft) {
					leftTouch=par.tiles[xTile-1][yTile].touches;
				} else {
					leftTouch=-1;
				}
				if (tileRight) {
					rightTouch=par.tiles[xTile+1][yTile].touches;
				} else {
					rightTouch=-1;
				}
				if (tileUp) {
					upTouch=par.tiles[xTile][yTile-1].touches;
				} else {
					upTouch=-1;
				}
				if(par.map[yTile][xTile]==3){//if oil tile
					switch(lastDirection){
						case "Down":
							if(downTouch!=-1){
								down();
							} else {
								testLeastTouch();
							}
							break;
						case "Up":
							if(upTouch!=-1){
								up();
							} else {
								testLeastTouch();
							}
							break;
						case "Right":
							if(rightTouch!=-1){
								right();
							} else {
								testLeastTouch();
							}
							break;
						case "Left":
							if(leftTouch!=-1){
								left();
							} else {
								testLeastTouch();
							}
							break;
					}
				} else {
					testLeastTouch();
				}
			} else {//not on desTile
				updateXY();
			}
		}
		private function testLeastTouch():void {
			leastTouches=[upTouch,rightTouch,downTouch,leftTouch];
				leastTouches.sort(Array.NUMERIC);
				if (leastTouches[leastTouches.length]!=-1) {//if there is a solution
					var goto:int=-1;
					//Find solution value//
					do {
						goto++;
					} while (leastTouches[goto]<0);//while not the solution
					///////////////////////

					//Goes to solution based on custom rank (down,left,right,up);
					if (downTouch==leastTouches[goto]) {
						down();
						lastDirection="Down";
					} else if (leftTouch==leastTouches[goto]) {
						left();
						lastDirection="Left";
					} else if (rightTouch==leastTouches[goto]) {
						right();
						lastDirection="Right";
					} else if (upTouch==leastTouches[goto]) {
						up();
						lastDirection="Up";
					}
				}
		}
		private function down():void {
			gotoAndStop(1);
			yTile++;
			par.tiles[xTile][yTile].touches++;
			par.tiles[xTile][yTile].updateTouchText();
			updateXY();
		}
		private function up():void {
			gotoAndStop(2);
			yTile--;
			par.tiles[xTile][yTile].touches++;
			par.tiles[xTile][yTile].updateTouchText();
			updateXY();
		}
		private function right():void {
			gotoAndStop(3);
			xTile++;
			par.tiles[xTile][yTile].touches++;
			par.tiles[xTile][yTile].updateTouchText();
			updateXY();
		}
		private function left():void {
			gotoAndStop(4);
			xTile--;
			par.tiles[xTile][yTile].touches++;
			par.tiles[xTile][yTile].updateTouchText();
			updateXY();
		}
		private function updateXY():void {
			if (par.tiles[xTile][yTile].x>x) {
				x+=wid*speed;
			} else if (par.tiles[xTile][yTile].x<x) {
				x-=wid*speed;
			}
			if (par.tiles[xTile][yTile].y>y) {
				y+=wid*speed;
			} else if (par.tiles[xTile][yTile].y<y) {
				y-=wid*speed;
			}
		}
		public function remove():void {
			if (hasEventListener(Event.ENTER_FRAME)) {
				removeEventListener(Event.ENTER_FRAME,onLoop);
			}
			par.removeChild(this);
		}
	}
}