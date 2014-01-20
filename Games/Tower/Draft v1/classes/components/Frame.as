/**
 * Contains frames for various content
 **/
package components {
	//foreign classes
	import buttons.QualityButton;
	import components.slider.CustomSlider;
	import graphic.Gear;
	//flash classes
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	public class Frame extends MovieClip {
		//constants
		private const EASE:Number = 0.1;
		
		//variables
		private var frameName:String;
		
		private var xDes:int;
		private var yDes:int;
		
		private var hideX:int;
		private var hideY:int;
		private var collapsedX:int;
		private var collapsedY:int;
		private var expandedX:int;
		private var expandedY:int;
		
		private var closeButtonX:int;
		private var closeButtonY:int;
		
		private var over:Boolean;//mouse is over the frame
		private var expanded:Boolean = false;//if the frame is currently expanded or not
		//MCs
		private var closeBtn:FrameCloseButton;
		
		private var par:MovieClip;//holder
		private var par2:MovieClip;//game.as
		
		//Frame vars
		//options
		private var gear:Gear;//for the options
		
		//awards
		private var awardsName:Array;
		private var awardsDescription:Array;
		
		private var awardsNameText:Array;
		private var awardsDescriptionText:Array;
		
		private var defaultColor:uint = 0x999999;//default unawarded text color
		private var color1:uint = 0x006699;//color for awards 1-4
		private var color2:uint = 0x349a01;//color for awards 5-8
		private var color3:uint = 0xff9900;//color for awards 9-12
		private var color4:uint = 0xcc0000;//color for awards 13-16
		private var color5:uint = 0x000000;//color for awards 17-20
		public function Frame(frameName:String):void {
			this.frameName = frameName;
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			par2 = MovieClip(parent.parent);
			setContent();
			setFilters();
			hideThis();
			if(frameName=="options") {//check mouse events for the gear
				addEventListener(MouseEvent.ROLL_OVER,rollingOver,false,0,true);
				addEventListener(MouseEvent.ROLL_OUT,rollingOut,false,0,true);
			}
			addEventListener(MouseEvent.CLICK,onClick,false,0,true);
			addEventListener(Event.ENTER_FRAME,onLoop,false,0,true);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		/**
		 * Sets the frame number and adds the content based on the frame name
		 **/
		private function setContent():void {
			switch(frameName) {
				case "awards":
					createAwards();
					break;
				case "options":
					createOptions();
					break;
			}
		}
		
		/**
		 * Creates the awards frame
		 **/
		private function createAwards():void {
			gotoAndStop(1);
			
			//set awards text
			awardsName = new Array();
			awardsName[0] = "Noob!";
			awardsName[1] = "Accolade's abode";
			awardsName[2] = "Crank up that music!";
			awardsName[3] = "Saphire";
			awardsName[4] = "Beginner";
			awardsName[5] = "Made by...";
			awardsName[6] = "Thunderstruck";
			awardsName[7] = "Emerald";
			awardsName[8] = "Great";
			awardsName[9] = "Taste of TNT";
			awardsName[10] = "Bombs Away!";
			awardsName[11] = "Diamond";
			awardsName[12] = "Expert";
			awardsName[13] = "Cu+Sn";
			awardsName[14] = "Ag";
			awardsName[15] = "Ruby";
			awardsName[16] = "Grand Master";
			awardsName[17] = "Au";
			awardsName[18] = "Onyx";
			awardsName[19] = "Gems of the sky";
			
			var awardsNameFormat:TextFormat = new TextFormat();
			awardsNameFormat.font = "Century Gothic";
			awardsNameFormat.size = 19;
			awardsNameFormat.align = TextFormatAlign.RIGHT;
			
			//awards description

			awardsDescription = new Array();
			awardsDescription[0] = "Earn 50+ points";
			awardsDescription[1] = "Go to the awards menu";
			awardsDescription[2] = "Go to the options menu";
			awardsDescription[3] = "Complete tier 1";
			awardsDescription[4] = "Earn 100+ points";
			awardsDescription[5] = "Go to the credits";
			awardsDescription[6] = "Be hit by lightning";
			awardsDescription[7] = "Complete tier 2";
			awardsDescription[8] = "Earn 500+ points";
			awardsDescription[9] = "Explode a bomb";
			awardsDescription[10] = "Explode 100 bombs";
			awardsDescription[11] = "Complete tier 3";
			awardsDescription[12] = "Earn 1000+ points";
			awardsDescription[13] = "Bronze for every level";
			awardsDescription[14] = "Silver for every level";
			awardsDescription[15] = "Complete tier 4";
			awardsDescription[16] = "Earn 5000+ points";
			awardsDescription[17] = "Gold for every level";
			awardsDescription[18] = "Complete tier 5";
			awardsDescription[19] = "Complete ALL levels";
			
			var awardsDescriptionFormat:TextFormat = new TextFormat();
			awardsDescriptionFormat.font = "Century Gothic";
			awardsDescriptionFormat.size = 19;
			awardsDescriptionFormat.align = TextFormatAlign.LEFT;
			
			awardsNameText = new Array();
			for(var a:uint = 0;a<awardsName.length;a++) {
				awardsNameText[a] = new TextField();
				awardsNameText[a].mouseEnabled = false;
				awardsNameText[a].selectable = false;
				awardsNameText[a].defaultTextFormat = awardsNameFormat;
				awardsNameText[a].textColor = defaultColor
				awardsNameText[a].text = awardsName[a];
				awardsNameText[a].x = 25;
				awardsNameText[a].y = 50+a*19;
				awardsNameText[a].width = 175;
				addChild(awardsNameText[a]);
			}
			
			awardsDescriptionText = new Array();
			for(var b:uint = 0;b<awardsDescription.length;b++) {
				awardsDescriptionText[b] = new TextField();
				awardsDescriptionText[b].mouseEnabled = false;
				awardsDescriptionText[b].selectable = false;
				awardsDescriptionText[b].defaultTextFormat = awardsDescriptionFormat;
				awardsDescriptionText[b].textColor = defaultColor;
				awardsDescriptionText[b].text = awardsDescription[b];
				awardsDescriptionText[b].x = 205;
				awardsDescriptionText[b].y = 50+b*19;
				awardsDescriptionText[b].width = 265;
				addChild(awardsDescriptionText[b]);
			}
			
			hideX = -350;
			hideY = 500;
			collapsedX = -290;
			collapsedY = 440;
			expandedX = 26;
			expandedY = 26;
			
			closeButtonX = 0;
			closeButtonY = 0;
			createCloseButton();
		}
		/**
		 * Updates the award colors
		 * @trigger When a new award is given or when loading old game save
		 **/
		private function updateColors():void {
			
			var awardsEarned:Array = par2.getAwardsEarned();//retrieves the awards earned
			
			//goes through all the colors and sets the color for the text
			for(var a:uint = 0;a<awardsEarned.length;a++) {
				if(a>=16) {
					awardsNameText[a].textColor = (awardsEarned[a])?color5:defaultColor;
					awardsDescriptionText[a].textColor = (awardsEarned[a])?color5:defaultColor;
				} else if(a>=12) {
					awardsNameText[a].textColor = (awardsEarned[a])?color4:defaultColor;
					awardsDescriptionText[a].textColor = (awardsEarned[a])?color4:defaultColor;
				} else if(a>=8) {
					awardsNameText[a].textColor = (awardsEarned[a])?color3:defaultColor;
					awardsDescriptionText[a].textColor = (awardsEarned[a])?color3:defaultColor;
				} else if(a>=4) {
					awardsNameText[a].textColor = (awardsEarned[a])?color2:defaultColor;
					awardsDescriptionText[a].textColor = (awardsEarned[a])?color2:defaultColor;
				} else {
					awardsNameText[a].textColor = (awardsEarned[a])?color1:defaultColor;
					awardsDescriptionText[a].textColor = (awardsEarned[a])?color1:defaultColor;
				}
			}
		}
		
		/**
		 * Creates the options frame
		 **/
		private function createOptions():void {
			gotoAndStop(2);
			
			//gear
			gear = new Gear(37,35);
			addChild(gear);
			
			//quality buttons
			var high:QualityButton = new QualityButton("high",130,80);
			var med:QualityButton = new QualityButton("medium",185,80);
			var low:QualityButton = new QualityButton("low",240,80);

			addChild(high);
			addChild(med);
			addChild(low);
			
			//slider
			var slider:CustomSlider = new CustomSlider(105,117);
			addChild(slider);
			
			hideX = 485;
			hideY = 490;
			collapsedX = 435;
			collapsedY = 440;
			expandedX = 102;
			expandedY = 152;
			
			closeButtonX = 240;
			closeButtonY = 0;
			createCloseButton();
		}
		
		/**
		 * Sets filters
		 **/
		private function setFilters():void {
			//light blue large radius glow
			var glow:GlowFilter = new GlowFilter();
			glow.blurX=23;
			glow.blurY=23;
			glow.strength=1.5;
			glow.color=0xbce6fc;
			this.filters=[glow];
		}
		
		/**
		 * Creates and adds the close button
		 **/
		private function createCloseButton():void {
			closeBtn = new FrameCloseButton(closeButtonX,closeButtonY);
			addChild(closeBtn);
		}
		
		//Frame movements
		/**
		 * Moves the frames to the hiding position
		 **/
		private function hideThis():void {
			expanded = false;
			xDes = hideX;
			yDes = hideY;
			x = hideX;
			y = hideY;
		}
		/**
		 * Sets the destination to the collapes position
		 **/
		public function collapse():void {
			xDes = collapsedX;
			yDes = collapsedY;
			expanded = false;
		}
		/**
		 * Sets the desination to the expand position
		 **/
		public function expand():void {
			xDes = expandedX;
			yDes = expandedY;
			expanded = true;
		}
		
		public function isExpanded():Boolean {
			return expanded;
		}
		
		//Events
		
		/**
		 * Moves the frame
		 **/
		private function onLoop(e:Event):void {
			if(!expanded) {
				if(Math.abs(xDes-x)<80) {
					addClick();
				}
			}
			x += (xDes-x)*EASE;
			y += (yDes-y)*EASE;
		}
		
		//Mouse Events
		
		/**
		 * Enables the frame to be expanded
		 **/
		public function addClick():void {
			addEventListener(MouseEvent.CLICK,onClick);
		}
		
		/**
		 * Expands or collapses the frame
		 **/
		private function onClick(e:MouseEvent):void {
			if(!expanded) {
				expand();
				removeEventListener(MouseEvent.CLICK,onClick);
			}
		}
		/**
		 * Mouse is over the frame
		 **/
		private function rollingOver(e:MouseEvent):void {
			over = true;
			gear.rotateOn();
		}
		/**
		 * Mouse is not over the frame
		 **/
		private function rollingOut(e:MouseEvent):void {
			over = false;
			gear.rotateOff();
		}
	}
}