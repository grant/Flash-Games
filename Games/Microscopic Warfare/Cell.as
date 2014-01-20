package {
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	public class Cell extends MovieClip {
		public var cellColor:CellColor;
		private var cellShading:CellShading;
		private var enemy:Boolean;
		private var movable:Boolean;
		public var ys:Number=0;
		public var xs:Number=0;
		private var startW:Number;
		private var startH:Number;
		public var theWidth:Number;
		public var theHeight:Number;
		public var desWidth:Number=0;
		public var desHeight:Number=0;
		private var limit:uint = 400;
		private var par:MovieClip;
		private var par2:MovieClip;
		public var upgradeAmount:uint=0;
		private const sW:uint = 550;
		private const sH:uint = 400;
		public var maxAmount:uint=0;
		public function Cell(e:Boolean,canMove:Boolean,xPos:Number,yPos:Number,wid:Number,hei:Number) {
			enemy = e;
			movable = canMove;
			x = xPos;
			y = yPos;
			startW = wid;
			startH = hei;
			theWidth = wid;
			theHeight = hei;
			desWidth = wid;
			desHeight = hei;
			cellColor = new CellColor(wid,hei);
			
			addChild(cellColor);
			cellShading = new CellShading(wid,hei);
			addChild(cellShading);
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			par2 = MovieClip(par.parent);
			if(!enemy){
				changeColor(par2.theColor);
				if(movable){
					stage.addEventListener(KeyboardEvent.KEY_DOWN,keyIsDown);
					stage.addEventListener(KeyboardEvent.KEY_UP,keyIsUp);
					addEventListener(Event.ENTER_FRAME,moveCell);
					addEventListener(Event.ENTER_FRAME,checkCollisions);
				}
				theWidth = 0;
				theHeight = 0;
				alpha = .8;
			} else {
				alpha = Math.random()*.3 + .65;
				xs = Math.random()*1-.5;
				ys = Math.random()*1-.5;
				do {
				x = Math.random()*(2*limit)-limit+(sW/2);
				} while(Math.abs(275-x)<theWidth/2);
				do {
				y = Math.random()*(2*limit)-limit+(sH/2);
				} while(Math.abs(200-y)<theHeight/2);
				changeColor(Math.random()*0xFFFFFF);
				addEventListener(Event.ENTER_FRAME,moveEnemy);
			}
			addEventListener(Event.ENTER_FRAME,squishSquash);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private var up:Boolean;
		private var down:Boolean;
		private var left:Boolean;
		private var right:Boolean;
		private function keyIsDown(e:KeyboardEvent):void {
			switch(e.keyCode){
				case 87://w
				case 38://up
					up=true;
					break;
				case 83://s
				case 40://down
					down=true;
					break;
				case 65://a
				case 37://left
					left=true;
					break;
				case 68://d
				case 39://right
					right=true;
					break;
				case 80://p
					if(par2.playingGame){
						if(!par2.pausing){
							par2.addChild(par2.bp);
							par2.pausing=true;
						} else {
							par2.removeChild(par2.bp);
							par2.pausing=false;
						}
					}
					break;
				case 82://r
					if(par2.dead){
						par2.removeDeath();
					}
					if(par2.playingGame){
						par2.removeGame();
						par2.setGame();
					}
					break;
				case 77://m
					if(par2.playingGame){
						par2.removeGame();
						par2.displayMenu();
					}
					if(par2.dead){
						par2.removeDeath();
					}
					break;
			}
		}
		private function keyIsUp(e:KeyboardEvent):void {
			switch(e.keyCode){
				case 87://w
				case 38://up
					up=false;
					break;
				case 83://s
				case 40://down
					down=false;
					break;
				case 65://a
				case 37://left
					left=false;
					break;
				case 68://d
				case 39://right
					right=false;
					break;
			}
		}
		public var acc:Number=.5;
		public var maxXs:Number=2;
		public var maxYs:Number=2;
		private var f:Number=.9;
		private function moveCell(e:Event):void {
			if(!par2.dead){
				if(!par2.pausing){
					if(!par2.win){
						if(up){
							ys -= acc;
						}
						if(down){
							ys += acc;
						}
						if(left){
							xs -= acc;
						}
						if(right){
							xs += acc;
						}
					}
				if(xs>maxXs){
					xs = maxXs;
				} else if(xs<-maxXs){
					xs = -maxXs;
				}
				if(ys>maxYs){
					ys = maxYs;
				} else if(ys<-maxYs){
					ys = -maxYs;
				}
				xs *= f;
				ys *= f;
				par2.cellXS=xs;
				par2.cellYS=ys;
				if(par2.enemies!=null){
					for(var i = 0;i <par2.numEnemies;i++){
						par2.enemies[i].x -= xs;
						par2.enemies[i].y -= ys;
					}
				}}
			}
		}
		private var bonusArea:Number = 1.2;
		public var cellIncrease:Number = 100;//larger = slower
		private var cellDecrease:Number = 50;//smaller = faster
		private var shrinkRate:uint = 40;//larger = slower
		private var colorRate:Number = .05;
		private function checkCollisions(e:Event):void {
			if(!par2.pausing&&!par2.win){
			if(par2.enemies!=null){
				for(var i = 0;i <par2.numEnemies;i++){
					if(Math.abs(x-par2.enemies[i].x)<(width/2)+(par2.enemies[i].width/2)){//right on edge
						if(Math.abs(y-par2.enemies[i].y)<(height/2)+(par2.enemies[i].height/2)){
							if(par2.enemies[i].width*par2.enemies[i].height<bonusArea*(width*height)){//smaller
								desWidth += Math.sqrt(Math.abs((Math.sqrt(theWidth*theHeight*bonusArea)-Math.sqrt((par2.enemies[i].theWidth*par2.enemies[i].theHeight)))))/cellIncrease;
								desHeight += Math.sqrt(Math.abs((Math.sqrt(theWidth*theHeight*bonusArea)-Math.sqrt((par2.enemies[i].theWidth*par2.enemies[i].theHeight)))))/cellIncrease;
								changeColor(par2.enemies[i].colorTransform.color,colorRate);
								par2.enemies[i].desWidth-=(par2.enemies[i].startW/shrinkRate);//(par2.enemies[i].desWidth/10);
								par2.enemies[i].desHeight-=(par2.enemies[i].startH/shrinkRate);
								if(par2.enemies[i].desWidth<5||par2.enemies[i].desHeight<5){
									var pop:Pop = new Pop(par2.enemies[i].x,par2.enemies[i].y);
									par2.addChild(pop);
									relocate(i);
								}
								if(!par2.win){
									if(theWidth>=140){
										par2.win=true;
										par2.pausing=false;
										desWidth=140;
										desHeight=140;
										par2.addChild(par2.tw);
									} else {
										upgradeAmount++;
									}
								}
								if(!par2.win){
									if(!par2.dead){
										if(!par2.pausing){
											if(upgradeAmount>=maxAmount){
												upgradeAmount=0;
												maxAmount*=1.2;
												par2.pausing=true;
												par2.doUp();
											}
										}	
									}
								}
							} else {
								if(Math.abs(x-par2.enemies[i].x)<(par2.enemies[i].width/2)){// even closer to each other
									if(Math.abs(y-par2.enemies[i].y)<(par2.enemies[i].height/2)){
										desWidth -= Math.sqrt(Math.abs((Math.sqrt(theWidth*theHeight*bonusArea)-Math.sqrt((par2.enemies[i].theWidth*par2.enemies[i].theHeight)))))/cellDecrease;
										desHeight -= Math.sqrt(Math.abs((Math.sqrt(theWidth*theHeight*bonusArea)-Math.sqrt((par2.enemies[i].theWidth*par2.enemies[i].theHeight)))))/cellDecrease;
										if(desWidth<5&&desHeight<5){
											desWidth = 0;
											desHeight = 0;
											if(!par2.dead){
												par2.dead=true;
												par2.addDeath();
											}
										}
									}
								}
							}
						}
					}
				}
			}
			}
		}
		private function relocate(i:uint):void {
			par2.enemies[i].changeColor(Math.random()*0xFFFFFF);
			do {
				par2.enemies[i].x = Math.random()*(2*limit)-limit+(sW/2);
			} while(par2.enemies[i].x+par2.enemies[i].theWidth*1.1>0&&par2.enemies[i].x-par2.enemies[i].theWidth*1.1<sW);
			do {
				par2.enemies[i].y = Math.random()*(2*limit)-limit+(sH/2);
			} while(par2.enemies[i].y+par2.enemies[i].theHeight*1.1>0&&par2.enemies[i].y-par2.enemies[i].theHeight*1.1<sW);
			par2.enemies[i].theWidth = par2.enemies[i].startW;
			par2.enemies[i].theHeight = par2.enemies[i].startH;
			par2.enemies[i].desWidth = par2.enemies[i].startW;
			par2.enemies[i].desHeight = par2.enemies[i].startH;
		}
		public function moveEnemy(e:Event):void {
			if(!par2.pausing){
				x += xs;
				y += ys;
				if(x > limit+(sW/2)){
					x = -limit+(sW/2);
					//y = Math.random()*(limit*2)-limit;
				} else if(x < -limit+(sW/2)){
					x = limit+(sW/2);
					//y = Math.random()*(limit*2)-limit;
				}
				if(y > limit+(sH/2)){
					y = -limit+(sH/2);
					//x = Math.random()*(limit*2)-limit;
				} else if(y< -limit+(sH/2)){
					y = limit+(sH/2);
					//x = Math.random()*(limit*2)-limit;
				}
			}
		}
		private var squish:uint = Math.random()*180;
		private var squishRate:uint = 10+Math.random()*10;
		private var squishAmount:Number = .1;
		private var growEase:Number=.1;
		private function squishSquash(e:Event):void {
			//if(!par2.pausing){
				squish+=squishRate;
				theHeight += (desHeight-theHeight)*growEase;
				theWidth += (desWidth-theWidth)*growEase;
				height = theHeight + (Math.sin((Math.PI/180)*squish))*(theHeight/10);
				width = theWidth+(Math.sin((Math.PI/180)*(squish+180)))*(theWidth*squishAmount);
			//}
		}
		private var colorTransform:ColorTransform;
		public function changeColor(color:uint,strength:Number=1):void {
			if(!par2.pausing){
				colorTransform = cellColor.transform.colorTransform;
				if(strength!=1){
					var cr:uint = this.colorTransform.redOffset;
					var cg:uint = this.colorTransform.greenOffset;
					var cb:uint = this.colorTransform.blueOffset;
					var er:uint = color/65536;
					var eg:uint = (color-(er*65536))/256;
					var eb:uint = color-(er*65536)-(eg*256);
					var fr:uint = cr-((cr-er)*strength);
					var fg:uint = cg-((cg-eg)*strength);
					var fb:uint = cb-((cb-eb)*strength);
					var finalColor:uint = (fr*65536)+(fg*256)+fb;
					colorTransform.color=finalColor;
				} else {
					colorTransform.color=color;
				}
				cellColor.transform.colorTransform=colorTransform;
			}
		}
		public function remove():void {
			if(!enemy){
				stage.removeEventListener(KeyboardEvent.KEY_DOWN,keyIsDown);
				stage.removeEventListener(KeyboardEvent.KEY_UP,keyIsUp);
				removeEventListener(Event.ENTER_FRAME,moveCell);
			} else {
				removeEventListener(Event.ENTER_FRAME,moveEnemy);
			}
			removeEventListener(Event.ENTER_FRAME,squishSquash);
			par.removeChild(this);
		}
	}
}