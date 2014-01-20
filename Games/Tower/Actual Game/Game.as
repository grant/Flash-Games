/**
 * In the final version of this game, make the new line come behind the tower
 **/
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	public class Game extends MovieClip {
		//Constants
		public const size:uint = 50;//20
		public const wid:uint = 11;//11
		public const spacing:uint = 0;//0
		public const ground:uint = 10; //bottom - x pixels
		public const startNumber:uint = 5;//5
		public const acceleration:uint = 1;
		
		private const cameraFollowHeight:Number = .5;//0-1 how hight the tower has to be until follows newLine.
		private const cameraEase:Number = .1;
		//Variables
		public var speed:Number = 1;
		public var totalWidth:uint = (size*wid)+((wid-1)*spacing);
		public var startX:Number;
		public var endX:Number;
		
		public var level:uint = 0;
		public var currentY:Number;
		public var currentNumber:uint = startNumber;
		
		private var cameraHeightLimit:Number;
		//Holder Data
		public var newLine:MovieClip;
		public var tower:MovieClip = new MovieClip();
		public var base:Array = new Array();
		public var h:Array = new Array();//holder for newLine squares
		public var blocks:Array = new Array();//block positions
		public var blockXPos:Array = new Array();
		//
		public function Game():void {
			addChild(tower);
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(Event.ENTER_FRAME,moveCamera);
		}
		private function onAdd(e:Event):void {
			cameraHeightLimit = (1-cameraFollowHeight)*stage.stageHeight;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onDown);
			
			startX = (stage.stageWidth-totalWidth+size)/2;
			endX = (stage.stageWidth+totalWidth+size)/2;
			
			checkForErrors();
			
			setBase();
			addLevel();
			
			setNewLine(level,startX,1);
			
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function setBase():void {
			setLevel();
			for(var w:uint = ((wid-1)/2)-((startNumber-1)/2); w<((wid-1)/2)-((startNumber-1)/2)+startNumber;w++){//add current blocks
				blocks[level][w]=1;
			}
			//set possible x positions array
			for(var e:uint = 0;e<wid;e++){
				blockXPos.push(startX+e*(size+spacing));
			}
			//add squares
			for(var a:uint = 0;a<blocks[level].length;a++){//add blocks to stage
				if(blocks[level][a]){//if there is a block here
					addSquare(startX+(a*(spacing+size)),findLevelY(level), startX+(a*(spacing+size)),findLevelY(level),size,size);
				}
			}
		}
		private function setLevel():void {
			blocks[level] = new Array();//set block array
			for(var q:uint = 0; q<wid;q++){//reset all blocks
				blocks[level][q]=0;
			}
		}
		private function addLevel():void {
			level++;
			setLevel();
			speed+=acceleration;
		}
		private function findLevelY(level:uint) {//default is current level
			return stage.stageHeight-ground-(size/2)-(level*(size+spacing));
		}
		private function addSquare(desx:int,desy:int,px:int,py:int,w:uint,h:uint):void {
			base.push(new Square(desx,desy,px,py,w,h));
			tower.addChild(base[base.length-1]);
		}
		private function setNewLine(level:uint,xpos:int,dir:int):void {
			newLine = new NewLine(dir,size);
			for(var b:uint = 0;b<currentNumber;b++){
				h[b] = new Square(b*(size+spacing),0,b*(size+spacing),0,size,size);
				newLine.addChild(h[b]);
			}
			newLine.x = xpos;
			newLine.y = findLevelY(level);
			addChild(newLine);
		}
		private function onDown(e:KeyboardEvent):void {
			if(e.keyCode==32){//space
				placeSquares();
			}
		}
		private function placeSquares():void {
			for(var c:uint = 0;c<currentNumber;c++){
				var px:Number = newLine.x+(-stage.stageWidth+totalWidth-size)/2;//distance from edge of first block
				var newpx:Number = (px%(size+spacing));//remander
				var desx:int;
				if(newpx<=(size+spacing)/2){
					//round down
					desx = -newpx;
				} else {
					//round up
					desx = ((size+spacing)-newpx);
				}
				desx+=px+startX+h[c].x;
				var xpos:Number;
				for(var d:uint = 0;d<wid;d++){//x block position
					if(desx===blockXPos[d]){
						xpos = d;
					}
				}
				var ypos:Number = 0;
				for(var e:uint = 0;e<=level;e++){//y block position
					if(blocks[e][xpos]===1){
						ypos=e+1;
					}
				}
				blocks[ypos][xpos] = 1;
				addSquare(desx,findLevelY(ypos),newLine.x+h[c].x,newLine.y,size,size);
			}
			resetNewLine();
		}
		private function resetNewLine():void {			
			currentNumber=0;
			for(var f:uint = 0;f<wid;f++){
				if(blocks[level][f]){
					currentNumber++;
				}
			}
			//can disable:
			//currentNumber = startNumber;
			for(var g:uint = 0;g<newLine.numChildren;g++){
				newLine.removeChild(h[g]);
			}
			var xpos:int = newLine.x;
			var dir:int = newLine.dir;
			newLine.remove();
			addLevel();
			setNewLine(level,xpos,dir);
		}
		private function moveCamera(e:Event):void {
			if(newLine.y<cameraHeightLimit){
				var des = cameraHeightLimit-newLine.y;
				y += (des-y)*cameraEase;
			}
		}
		private function checkForErrors():void {
			if(wid%2==0){
				error("var wid is even");
			}
			if(startNumber%2==0){
				error("var startNumber is even");
			}
			if(startNumber>wid){
				error("startNumber is greater than wid");
			}
			if(startX<0){
				error("wid/spacing/size is too high. Please lower one or more of these variables");
			}
		}
		private function error(msg:String):void {
			trace("Error: "+msg);
		}
	}
}