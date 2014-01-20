/**
 * Level selection buttons
 **/
package buttons{
	//foreign classes
	import graphic.CustomGraphic;
	//flash classes
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	public class LevelButton extends MovieClip {
		//constants

		//size
		private const DEFAULT_WIDTH:uint=58;
		private const DEFAULT_HEIGHT:uint=35;
		private const CLOSENESS_PERCENTAGE:Number=0.7;//how much does how close you are to the button matter when figuring how big the button is
		private const CLOSENESS_DISTANCE:uint=300;//how close do you have to be to the button for it to make it bigger than normal
		private const SIZE_EASE:Number=.2;//how fast the clouds change to their destination size

		//movememnt
		//wind
		private const WIND_POWER:uint=5;//The larger the number, the farther away the clouds are pushed
		private const CLOUD_RESET_EASE:Number=0.5;//The larger the number, the slower it eases back
		private const WIND_RADIUS:uint=300;//How close the mouse has to be for the wind to affect the cloud

		private var DES_X:int;
		private var DES_Y:int;
		private const EASE:Number=0.05;

		//variables
		private var halt:Boolean = false;
		
		//x,y
		private var desX:int;
		private var desY:int;
		//wid,hei
		private var desWid:uint;
		private var desHei:uint;

		private var id:uint;//the level number
		private var unlocked:Boolean = false;
		
		//MCs
		private var lock:CustomGraphic = new CustomGraphic("lock");
		
		private var par:MovieClip;//levelHolder
		private var par2:MovieClip;//game.as
		public function LevelButton(id:uint):void {
			this.id=id;
			this.buttonMode = true;
			gotoAndStop(id);
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			addEventListener(Event.ENTER_FRAME,onLoop,false,0,true);
			addEventListener(MouseEvent.CLICK,onClick,false,0,true);
			addEventListener(MouseEvent.ROLL_OVER,rollingOver,false,0,true);
			addEventListener(MouseEvent.ROLL_OUT,rollingOut,false,0,true);
			par=MovieClip(parent);
			par2=MovieClip(parent.parent);
			setXY();
			setWidHei();
			addLock();
			setLocked();
			setFilters();
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}

		/**
		 * Sets the destination X and Y positions based on a 4x5 button arangement
		 **/
		private function setXY():void {
			DES_X = 100+((id-1)%4)*100;//100 offset, 100 spacing per 4 columns
			DES_Y = 100+Math.floor((id-1)*0.25)*75;//100 offset, 75 spacing per 4 columns
			
			resetPosition();
		}

		/**
		 * Sets the width and height
		 **/
		private function setWidHei():void {
			width=DEFAULT_WIDTH;
			height=DEFAULT_HEIGHT;
		}
		
		/**
		 * Adds the lock graphic
		 * @trigger Auto-added when the level button is added
		 **/
		private function addLock():void {
			lock.width *= 3;
			lock.height *= 3;
			addChild(lock);
		}
		
		/**
		 * Sets if the level button is locked or not. Also removes the lock graphic if needed
		 **/
		private function setLocked():void {
			//Removing the lock assumes that unlocking is a one way.
			//This method needs to be changed if the level can turn from an unlocked position to a locked position
			if(unlocked!=par2.isUnlocked(id)) {//if there was a change in locked
				removeChild(lock);//remove the lock
			}
			unlocked = par2.isUnlocked(id);
		}

		/**
		 * Sets filters
		 **/
		private function setFilters():void {
			//erase/reset all filters
			this.filters = undefined;
			
			//light blue large radius glow
			var glow:GlowFilter = new GlowFilter();
			glow.blurX=23;
			glow.blurY=23;
			glow.strength=1.5;
			glow.color=0xbce6fc;
			
			this.filters=[glow];
			
			if(!unlocked) {
				this.alpha = .5;
			}
		}

		/**
		 * Checks if the current locking state of the button needs to be changed. Changes the filter and "locked" variable
		 * @trigger Whenever a new level might be unlocked
		 **/
		private function checkLocked():void {
			setLocked();
			setFilters();
		}

		/** 
		 * Moves and sizes the level button cloud
		 **/
		private function onLoop(e:Event):void {
			if (! halt) {

				//Calculates distances for size and wind
				var xDis:uint=Math.abs(x-stage.mouseX);
				var yDis:uint=Math.abs(y-stage.mouseY);
				var distance:uint = Math.sqrt((xDis*xDis)+(yDis*yDis));

				//calculate size
				var addedSizePercent:Number = Math.abs((Math.min(CLOSENESS_DISTANCE,distance)/CLOSENESS_DISTANCE)-1);
				desWid = DEFAULT_WIDTH + (addedSizePercent*CLOSENESS_PERCENTAGE*DEFAULT_WIDTH);
				desHei = DEFAULT_HEIGHT + (addedSizePercent*CLOSENESS_PERCENTAGE*DEFAULT_HEIGHT);

				//update size
				width += (desWid-width)*SIZE_EASE;
				height += (desHei-height)*SIZE_EASE;

				//get wind
				var wind:Array=par2.getWind();

				//calculates how much power the wind has based on the distance between the mouse and the cloud
				var disPercent:Number = Math.abs((Math.min(WIND_RADIUS,distance)/WIND_RADIUS)-1);

				if (wind[0]!=undefined) {
					//change the destination x and y based on the wind speed and distance
					desX += (wind[0]*WIND_POWER*disPercent);
					desY += (wind[1]*WIND_POWER*disPercent);
				}

				//bring the clouds back to their normal position a bit
				desX = ((desX - DES_X) * CLOUD_RESET_EASE)+DES_X;
				desY = ((desY - DES_Y) * CLOUD_RESET_EASE)+DES_Y;

				//update position
				x += (desX - x)*EASE;
				y += (desY - y)*EASE;
			}
		}

		/**
		 * Resets the position of the clouds to off the screen
		 **/
		public function resetPosition():void {
			desX=DES_X;
			desY=DES_Y;

			//the "5" in the two following equasions can change
			//it stands for the power/distance the clouds start at
			x = (desX-(stage.stageWidth*0.5))*5+(stage.stageWidth*0.5);//(displacement from centerX)*distance + centerX
			y = (desY-(stage.stageHeight*0.5))*5+(stage.stageHeight*0.5);//(displacement from centerY)*distance + centerY
		}

		/**
		 * Stops all movement and sizing
		 **/
		public function hold():void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
		}

		/**
		 * Mouse Events
		 **/
		private function onClick(e:MouseEvent):void {

		}
		private function rollingOver(e:MouseEvent):void {
			//gotoAndStop(2);
		}
		private function rollingOut(e:MouseEvent):void {
			//gotoAndStop(1);
		}
		
		/**
		 * Removes the button
		 **/
		public function remove():void {
			removeEventListener(Event.ENTER_FRAME,onLoop);
			par.removeChild(this);
		}
	}
}