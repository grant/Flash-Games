//View of the world
/* Public methods
moveCameraTo(px,py)
centerCameraTo(px,py)
easeMoveCameraTo(px,py)
centerMoveCameraTo(px,py)
setWorldMap(worldMap)
getWorldMap():WorldMap
getChar():Char
*/
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	public class WorldViewer extends MovieClip {
		//constants
		public const SCALE:Number = 1;
		public const TILE_WIDTH:uint=50*SCALE;
		public const TILE_HEIGHT:uint=50*SCALE;
		//world objects
		private var worldMap:WorldMap;
		private var worldTiles:Array;
		//child objects
		private var char:Char;//user character
		//camera controls
		private var px:Number = 0;//the top left x position of the camera relative to the origin of the map (top left)
		private var py:Number = 0;//the top left y position of the camera relative to the origin of the map (top left)
		private var desX:Number = 0;//the top left destination x position of the camera relative to the origin of the map (top left)
		private var desY:Number = 0;//the top left destination y position of the camera relative to the origin of the map (top left)
		private const CAMERA_EASE:Number = 1;//The rate at which the camera moves to the desX, desY (values: 0 to 1) (slow to fast)

		//layers
		private var tileLayer:MovieClip;//tile
		private var charLayer:MovieClip;//user character
		public function WorldViewer():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			setup();
			addEventListener(Event.ENTER_FRAME,onLoop);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
			var a:Array = new Array();
		}

		//
		//SETUP
		//

		//sets up the world viewer
		private function setup():void {
			setWorldMap(new WorldMap());
			setLayers();
			addTiles();
			addChar();
			addEventListener(Event.ENTER_FRAME,moveCamera);
		}

		//sets up the layers
		private function setLayers():void {
			tileLayer = new MovieClip();
			addChild(tileLayer);
			charLayer = new MovieClip();
			addChild(charLayer);
		}

		//adds tiles to the viewer
		private function addTiles():void {
			worldTiles = new Array();
			//for all all the map tiles
			for (var i:uint = 0; i<worldMap.getMapHeight(); i++) {//Y
				for (var j:uint = 0; j<worldMap.getMapWidth(); j++) {//X
					var tileId:uint=worldMap.getTileId(new Point(j,i));
					if (tileId==1) {
						//add a tile to the worldTile list
						worldTiles.push(new Tile(tileId,j,i,TILE_WIDTH,TILE_HEIGHT));
						//add the tile to the display list
						tileLayer.addChild(worldTiles[worldTiles.length-1]);
					}
				}
			}
		}
		
		//adds the char to the viewer
		private function addChar():void {
			char = new Char(1,0,TILE_WIDTH,TILE_HEIGHT);
			charLayer.addChild(char);
			//easeCenterCameraTo(0,0);
		}
		
		//
		//EVENTS
		//
		
		//run every frame
		private function onLoop(e:Event):void {
			easeCenterCameraTo(char.x,char.y);
		}
		
		//
		//CAMERA CONTROLS
		//
		
		//gets the camera's x position
		public function getCameraX():Number {
			return -x;
		}
		
		//gets the camera's y position
		public function getCameraY():Number {
			return -y;
		}
		
		//moves the top left position of the camera to position (px,py)
		public function moveCameraTo(px:Number,py:Number):void {
			this.px = px;
			this.py = py;
			x = -px;
			y = -py;
		}
		
		///moves the center of the camera to position (px,py)
		public function centerCameraTo(px:Number,py:Number):void {
			moveCameraTo(px-(stage.stageWidth/2),py-(stage.stageHeight/2));
		}
		
		//eases to the top left position of the camera to position (px,py)
		public function easeMoveCameraTo(px:Number,py:Number):void {
			desX = px;
			desY = py;
		}
		
		//eases to the center of the camera to position (px,py)
		public function easeCenterCameraTo(px:Number,py:Number):void {
			desX = px-(stage.stageWidth/2);
			desY = py-(stage.stageHeight/2);
		}
		
		//move camera based off of the top left position
		private function moveCamera(e:Event):void {
			var newX = getCameraX();
			var newY = getCameraY();
			newX += (desX-newX)*CAMERA_EASE;
			newY += (desY-newY)*CAMERA_EASE;
			moveCameraTo(newX,newY);
		}

		//
		//SETTERS
		//

		//sets the world map
		public function setWorldMap(newWorldMap:WorldMap):void {
			worldMap=newWorldMap;
		}

		//
		//GETTERS
		//

		//gets the world map
		public function getWorldMap():WorldMap {
			return worldMap;
		}
		
		//gets the char
		public function getChar():Char {
			return char;
		}
		
		//gets the view scale of the world
		public function getScale():Number {
			return SCALE;
		}
	}
}