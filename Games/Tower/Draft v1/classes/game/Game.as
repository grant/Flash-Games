/**
 * The tower game
 **/
package game {
	//Import foreign classes
	import background.BgColor;
	import background.BirdLayer;
	import background.Butterfly;
	import buttons.Credits;
	import buttons.Play;
	import buttons.LevelButton;
	import components.Frame;
	import components.Message;
	import graphic.CustomGraphic;
	import rgbcolor.RGBColor;
	import transitions.Fader;
	
	//import flash classes
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Game extends MovieClip {
		
		//Variables
		private var timer:uint = 0;
		private var levelsUnlocked:uint = 1;
		private var levelSelection:Boolean = true;
		
		private var messageDisplayed:Boolean = false;
		
		private var awardsEarned:Array;
		
		//Display MCs
		private var bgColor:BgColor = new BgColor();
		private var backClouds:CustomGraphic;
		private var birdLayer:BirdLayer = new BirdLayer();
		private var backIntro:Intro_back = new Intro_back();
		private var middleClouds:CustomGraphic;
		private var frontIntro:Intro_front = new Intro_front();
		private var frontClouds:CustomGraphic;
		private var playBtn:Play = new Play();
		
		private var butterflies:Array = new Array();
		private var butterflyHolder:MovieClip = new MovieClip();
		
		private var levelButtons:Array = new Array();
		private var levelButtonHolder:MovieClip = new MovieClip();
		
		private var credits:Credits = new Credits();
		
		private var frameHolder:MovieClip = new MovieClip();
		private var awards:Frame = new Frame("awards");
		private var options:Frame = new Frame("options");
		
		public var fader:Fader = new Fader();
		private var msg:Message = new Message();
		
		public function Game():void {
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			createLayers();
			addLayers();
			createAwards();
			addEventListener(Event.ENTER_FRAME,onLoop,false,0,true);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		/**
		 * Creates various MovieClips for the stage
		 **/
		private function createLayers():void {
			backClouds = new CustomGraphic("back_clouds");
			middleClouds = new CustomGraphic("middle_clouds");
			frontClouds = new CustomGraphic("front_clouds");
		}
		
		/**
		 * Adds layers to the stage
		 **/
		private function addLayers():void {
			//background
			addChild(bgColor);
			addChild(backClouds);
			addChild(birdLayer);
			
			addChild(backIntro);
			
			addChild(middleClouds);
			
			addChild(frontIntro);
			addChild(butterflyHolder);
			addChild(playBtn);
			
			addChild(frontClouds);
			
			addChild(levelButtonHolder);
			createLevelButtons();
			
			addChild(credits);
			
			addChild(frameHolder);
			frameHolder.addChild(awards);
			frameHolder.addChild(options);
			
			addChild(fader);
			fader.whiteToTransparent();
			
			addChild(msg);
		}
		
		/**
		 * Creates awards array
		 **/
		private function createAwards():void {
			awardsEarned = new Array();
			//set all awards earned to false
			for(var a:uint = 0;a<20;a++) {
				awardsEarned[a] = Math.random()<.5?true:false;
			}
		}
		
		/**
		 * Gets the awards array
		 **/
		public function getAwardsEarned():Array {
			return awardsEarned;
		}
		
		/**
		 * Checks if the level is unlocked or not
		 **/
		public function isUnlocked(level:uint) {
			var unlocked:Boolean;
			if(levelsUnlocked>=level) {
				unlocked = true;
			} else {
				unlocked = false;
			}
			return unlocked;
		}
		
		/**
		 * Loops every frame. The main events are all triggered/established here
		 **/
		private function onLoop(e:Event):void {
			timer++;
			checkIntro();
			//birds
			if(timer%40==0) {//create a bird every 20/24ths of a second
				birdLayer.addBird();
			}
			birdLayer.moveBirds();
			if(levelSelection) {//if on the level selection menu
				addMouseWind();
			}
			if(timer==1000) {
				timer = 0;
			}
		}
		
		/**
		 * Check for keyframes of intro
		 **/
		private function checkIntro():void {
			if(backIntro.currentFrame==180) {//bring play button to center
				playBtn.toCenter();
			} else if(backIntro.currentFrame==220) {//show the credits
				credits.makeVisible();
			} else if(backIntro.currentFrame==249) {//pausing for play button to be clicked
				backIntro.stop();
				frontIntro.stop();
			} else if(backIntro.currentFrame==backIntro.totalFrames) {//at the end of the animation
				removeChild(backIntro);
				removeChild(frontIntro);
				removeChild(playBtn);
				toLevelSelection();
			}
		}
		
		/**
		 * Continues the intro page
		 **/
		public function continueIntro():void {
			backIntro.play();
			frontIntro.play();
			playBtn.toBottom();
		}
		
		/**
		 * Adds a message to the screen
		 **/
		public function addMessage(messageName:String):void {
			if(!messageDisplayed) {//if there is not message currently showing
				fader.toBlack();//fade to black
				msg.setMessage(messageName);//set the message data
				msg.run();//show the message
			}
		}
		
		/**
		 * Adds a butterfly to the butterflyHolder
		 **/
		public function addButterfly(px:uint,py:uint):void {
			butterflies.push(new Butterfly(px,py));
			butterflyHolder.addChild(butterflies[butterflies.length-1]);
		}
		
		//level selection
		
		/**
		 * Creates the level buttons
		 **/
		private function createLevelButtons():void {
			for(var a:uint = 0;a<20;a++) {
				levelButtons.push(new LevelButton(a+1));
			}
		}
		/**
		 * Remove level buttons
		 **/
		private function removeLevelButtons():void {
			for(var a:uint = 0;a<20;a++) {
				levelButtons[a].remove();
			}
		}
		/**
		 * Adds the level selection buttons
		 **/
		private function toLevelSelection():void {
			levelSelection = true;
			for(var a:uint = 0;a<20;a++) {
				levelButtonHolder.addChild(levelButtons[a]);
			}
			//adds the awards and options frames to visible view
			awards.collapse();
			options.collapse();
		}
		
		//wind
		
		/**
		 * Adds wind to the level selection button based on the mouse's movement
		 **/
		//previous x and y positions 2 frames ago and 1 frame ago
		private var prevX2:int = 250;
		private var prevY2:int = 250;
		private var prevX:int = 250;
		private var prevY:int = 250;
		
		private var wind:Array = new Array();
		private function addMouseWind():void {
			
			wind[0] = (stage.mouseX-prevX2);
			wind[1] = (stage.mouseY-prevY2);
			
			//set previous mouse X and Y
			prevX2 = prevX;
			prevY2 = prevY;
			
			prevX = stage.mouseX;
			prevY = stage.mouseY;
		}
		/**
		 * Gets the raw wind speed for the levelButton
		 **/
		public function getWind():Array {
			return wind;
		}
	}
}