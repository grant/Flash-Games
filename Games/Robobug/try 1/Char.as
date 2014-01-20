//the moveable character
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public class Char extends MovieClip {
		//constants
		const JUMP_SPEED:Number = 20;
		const MAX_HORIZ_AIR_SPEED:Number = 10;
		const MAX_HORIZ_GROUND_SPEED:Number = 10;
		const HORIZ_ACC:Number = 5;
		const GROUND_FRICTION:Number = 0.7;
		const AIR_FRICTION:Number = 0.94;
		//constructor
		var startWid:Number;
		var startHei:Number;
		
		//PROPERTIES
		var scale:Number = 1;
		//booleans
		var gravityEnabled:Boolean = true;//has gravity or not
		var touchingGround:Boolean = false;//if bottom of char touching a tile
		var touchingCeiling:Boolean = false;//if top of char is touching a tile
		var touchingLeftWall:Boolean = false;//if the left side of char touching a tile
		var touchingRightWall:Boolean = false;//if the right side of char touching a tile
		//movement
		var vx:Number = 0;
		var vy:Number = 0;
		//position//
		var prevFrameLeftTile:int = 0;//the tile on the left of the character on the last frame
		var prevFrameRightTile:int = 0;//the tile on the right of the character on the last frame
		var prevLeftTile:int = 0;//last unique tile the left of the character went over
		var prevRightTile:int = 0;//last unique tile the right of the character went over
		var leftTile:int = 0;//the tile on the left of the character
		var rightTile:int = 0;//the tile on the right of the character
		//position of the bottom middle origin of the character
		var prevFrameTileX:int = 0;//last tile on the last frame
		var prevFrameTileY:int = 0;//last tile on the last frame
		var prevTileX:int = -1;//last unique tile went over (different than current tileX)
		var prevTileY:int = -1;//last unique tile went over (different than current tileY)
		var tileX:int = 0;//tile # relative to origin (bottom middle of char)
		var tileY:int = 0;//tile # relative to origin (bottom middle of char)
		
		//collision detections
		var tileCollisionRect:Rectangle;
		
		//debug
		var debugMode:Boolean = true;
		var d:DebugRect;
		public function Char(startTileX:Number,startTileY:Number,wid:Number,hei:Number):void {
			x = startTileX*Main.GAME.WORLD_VIEWER.TILE_WIDTH+(wid/2);
			y = startTileY*Main.GAME.WORLD_VIEWER.TILE_HEIGHT;
			startWid = wid;
			startHei = hei;
			width = startWid;
			height = startHei;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			setup();
			addEventListener(Event.ENTER_FRAME,onLoop);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//setups the char
		private function setup():void {
			tileCollisionRect = new Rectangle(+25,50,50,50);//-25,-50,50,50
			if(debugMode) {
				var f:Number = 1.2;//arbitrary constant that makes the debug rect look nice in the right place
				d = new DebugRect(new Rectangle(tileCollisionRect.x*f,tileCollisionRect.y*f,tileCollisionRect.width*f,tileCollisionRect.height*f));
				addChild(d);
			}
		}
		
		//on loop
		private function onLoop(e:Event):void {	
			//update given vars
			scale = Main.GAME.WORLD_VIEWER.getScale();
			
			/////////////////
			//keyboard events
			/////////////////
			if(Main.GAME.KEYBOARD.LEFT) {
				vx -= HORIZ_ACC;
			}
			if(Main.GAME.KEYBOARD.RIGHT) {
				vx += HORIZ_ACC;
			}
			if(Main.GAME.KEYBOARD.DOWN) {
				
			}
			
			///////////
			//move char
			///////////
			//change velocities
			//gravity
			if(gravityEnabled) {
				vy += Main.GAME.BUG_GRAVITY;
			}
			if(touchingGround) {
				vx *= GROUND_FRICTION;
			} else {
				vx *= AIR_FRICTION;
			}
			
			//max velocities (at end)
			//makes sure that the velocities are not above or below the max velocity
			var MAX_HORIZ_ACC = (touchingGround)?MAX_HORIZ_GROUND_SPEED:MAX_HORIZ_AIR_SPEED;
			if(vx>MAX_HORIZ_ACC) {
				vx=MAX_HORIZ_ACC;
			} else if(vx<-MAX_HORIZ_ACC) {
				vx=-MAX_HORIZ_ACC;
			}
			
			//change actual position
			x += vx*scale;
			y += vy*scale;
			
			//DONE WITH MOVEMENT, NOW ADJUST AND UPDATE VARS
			
			//update variables
			tileX = Math.floor((x+tileCollisionRect.x+tileCollisionRect.width/2)/Main.GAME.WORLD_VIEWER.TILE_WIDTH);
			tileY = Math.floor((y+tileCollisionRect.bottom)/Main.GAME.WORLD_VIEWER.TILE_HEIGHT);
			prevTileX = (prevFrameTileX!=tileX)?prevFrameTileX:prevTileX;
			prevTileY = (prevFrameTileY!=tileY)?prevFrameTileY:prevTileY;

			prevFrameLeftTile = leftTile;
			prevFrameRightTile = rightTile;
			leftTile
			rightTile
			////
			//collisions (tile)
			//
			//Collides with tileCollisionRect
			//Vertical (2): Bottom Center, Top Center
			//Horizontal (4): Four Corners
			////
			
			
			//check if touching wall
			//left corners touching wall
			touchingLeftWall = false;
			if(vx<0) {//moving left
				var tileId = 0;
			}
			//right corners touching wall
			touchingRightWall = false;
			if(vx>0) {//moving right
				
			}
			
			/*
			//check if touching wall
			touchingWall = false;
			//left
			for(var a:uint = prevFrameTileX;a<=tileX;a++) {
				var tileId:int = Main.GAME.WORLD_VIEWER.getWorldMap().getTileId(new Point(a,tileY));
				if(tileId>0) {
					touchingWall = true;
				}
				x = 100;
			}
			//right
			*/
			
			//
			
			//check if on ground and ceiling
			touchingGround = false;
			touchingCeiling = false;
			var tileId:int;//tile currently on
			if(vy>0) {//moving down (ground)
				var hasGround:Boolean = false;
				if(vy>Main.GAME.WORLD_VIEWER.TILE_HEIGHT) {//moving so fast that the char is passing through multiple tiles
					//WARNING: THIS BLOCK OF CODE IS MESSY AND UNRELIABLE WHEN GRAVITY IS HIGH
					//loops through all the tiles passed until it reaches one (if so)
					var done:Boolean = false;
					for(var i:uint = prevFrameTileY;i<=tileY;i++) {//for all tiles that passed from prev frame to this frame
						//check if one is a ground tile
						tileId = Main.GAME.WORLD_VIEWER.getWorldMap().getTileId(new Point(tileX,i));
						if(Main.GAME.WORLD_VIEWER.getWorldMap().isGroundTile(tileId)) {//is ground tile
							//if(prevTileY<tileY) {//if the char came from above
								if(!done) {//go unless you have already hit a tile
									hasGround = true;
									done = true;
									if(!Main.GAME.WORLD_VIEWER.getWorldMap().isGroundTile(Main.GAME.WORLD_VIEWER.getWorldMap().getTileId(new Point(tileX,tileY)))) {
										tileY--;//go above the tile
									}
								}
							//}
						}
					}
				} else {//normal vy
					tileId = Main.GAME.WORLD_VIEWER.getWorldMap().getTileId(new Point(tileX,tileY));
					if(Main.GAME.WORLD_VIEWER.getWorldMap().isGroundTile(tileId)) {//is ground tile
						if(prevTileY<tileY) {//if the char came from above (prevents jumping up if on a non-ceiling tile and falling
							hasGround = true;
						}
					}
				}
				touchingGround = hasGround;
			} else if(vy<0) {//going up (ceiling)
				tileId = Main.GAME.WORLD_VIEWER.getWorldMap().getTileId(new Point(tileX,tileY-1));
				if(Main.GAME.WORLD_VIEWER.getWorldMap().isCeilingTile(tileId)) {//is ceiling tile
					touchingCeiling = true;
				}
			}
			
			//use touchingGround information
			if(touchingGround) {
				y = (tileY)*Main.GAME.WORLD_VIEWER.TILE_HEIGHT-tileCollisionRect.bottom;
				//change vy
				if(Main.GAME.KEYBOARD.UP) {
					vy = -JUMP_SPEED;
				} else {
					vy = 0;
				}
			} else {//in air
				
			}
			
			//use touchingCeiling information
			if(touchingCeiling) {
				y = (tileY+1)*Main.GAME.WORLD_VIEWER.TILE_HEIGHT-tileCollisionRect.bottom;
				vy = 0;
			}
			
			//update variables
			prevFrameTileX = tileX;
			prevFrameTileY = tileY;
		}
	}
}