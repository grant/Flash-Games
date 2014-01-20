//music
//bubbles
package {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.display.Loader;
	import flash.media.SoundChannel;
	import flash.media.Sound;
	public class Main extends MovieClip {
		public var titleMenu:MovieClip;
		private var bg:Background;
		private var cellDisplay:Cell;
		private var playBTN:ButtonAS;
		public var bestTime:TextBox;
		private var logo:Logo;
		public var pausing:Boolean=false;
		public var playingGame:Boolean=false;
		public var dead:Boolean=false;
		public var win:Boolean=false;
		public var hsMin:uint=99;
		public var hsSec:uint=99;
		public var theColor:uint=0xFFFFFF;
		public var firstTime:Boolean=true;
		public var snd:Sound = new Sound();
		public var myChannel:SoundChannel = new SoundChannel();
		public var musicOn:Boolean=true;
		public var musicBTN:ButtonAS;
		public var _mochiads_game_id:String = "347b37edd3ed13f4";
		public function Main() {
			titleMenu = new MovieClip();

			bg=new Background(0,0);
			titleMenu.addChild(bg);
			cellDisplay=new Cell(false,false,165,207,246,311);
			titleMenu.addChild(cellDisplay);
			playBTN=new ButtonAS("play",350,250,150,60);
			titleMenu.addChild(playBTN);
			musicBTN=new ButtonAS("music",350,315,150,60);
			titleMenu.addChild(musicBTN);
			bestTime=new TextBox("best",0,0);
			titleMenu.addChild(bestTime);
			logo=new Logo(410,50);
			titleMenu.addChild(logo);
			logo.width/=1.2;

			displayMenu();
			snd.addEventListener(Event.COMPLETE,done);
			//var req:URLRequest = new URLRequest("280843_Coiin___Colour_My_World.mp3");
			//snd.load(req);
			
			var loader:Loader = new Loader();
			snd.load(new URLRequest(getSourceURL() + "280843_Coiin___Colour_My_World.mp3"));
			
		}
		//Next Optional
		public function getSourceURL():String {
  		  var resURL:String = this.loaderInfo.loaderURL;
  		  /* Get the URL minus everything after the last '/' */
  		  return resURL.substring(0, resURL.lastIndexOf("/") + 1);
		}
		public function done(e:Event):void {
			var local:Sound = e.target as Sound;
			myChannel = local.play(0,99);
		}
		public function displayMenu():void {
			addChild(titleMenu);
		}
		public function removeMenu():void {
			removeChild(titleMenu);
		}
		public function updateScore():void {

		}
		public var cell:Cell=new Cell(false,true,275,200,20,20);
		public var cellXS:Number;
		public var cellYS:Number;
		public var menuBTN:ButtonAS;
		public var pauseBTN:ButtonAS;
		public var restartBTN:ButtonAS;
		public var timer:TextBox;
		public var game:MovieClip = new MovieClip();
		public var inst:Inst;
		public var bar:Bar;
		public function setGame():void {
			addEnemies();
			cell.width=1;
			cell.height=1;
			cell.desWidth=20;
			cell.desHeight=20;
			cell.theWidth=1;
			cell.theHeight=1;
			cell.xs=0;
			cell.ys=0;
			cell.upgradeAmount=0;
			cell.maxAmount=150;
			cell.acc=.5;
			cell.maxXs=2;
			cell.maxYs=2;
			cell.cellIncrease=100;
			game.addChild(cell);

			menuBTN=new ButtonAS("menu",270,0,90,30);
			game.addChild(menuBTN);
			pauseBTN=new ButtonAS("pause",370,0,90,30);
			game.addChild(pauseBTN);
			restartBTN=new ButtonAS("restart",470,0,90,30);
			game.addChild(restartBTN);
			timer=new TextBox("timer",0,0);
			game.addChild(timer);
			bar=new Bar(5);
			game.addChild(bar);

			pausing=false;
			playingGame=true;
			dead=false;

			addChild(game);
			
			if(firstTime){
				firstTime=false;
				pausing=true;
				inst = new Inst();
				addChild(inst);
			}
		}
		public function removeGame():void {
			removeEnemies();
			game.removeChild(cell);
			menuBTN.remove();
			//musicBTN.remove();
			pauseBTN.remove();
			restartBTN.remove();
			timer.remove();
			bar.remove();
			theColor = cell.cellColor.transform.colorTransform.color;
			cellDisplay.changeColor(theColor);
			
			win=false;
			if(pausing){
				removeChild(bp);
			}
			pausing=false;
			playingGame=false;

			removeChild(game);
		}
		public var numEnemies:uint=100;
		public var enemies:Array;
		public function addEnemies():void {
			enemies = new Array();
			for (var i=0; i<numEnemies; i++) {
				var wid:Number=10+Math.random()*100;
				//wid = 10-100;
				//hei = (1/3) close to wid
				enemies.push(  new Cell(true,false,0,0,wid,((2/3)*wid)+(Math.random()*((2/3)*wid))));
				game.addChild(enemies[i]);
			}
		}
		public function removeEnemies():void {
			for (var i=0; i<numEnemies; i++) {
				game.removeChild(enemies[i]);
				enemies[i]=null;
			}
			enemies=null;
		}
		public var black:ToBlack;
		public var mBTN:ButtonAS;
		public var rBTN:ButtonAS;
		public var hs:Hs;
		public function addDeath():void {
			black = new ToBlack();
			addChild(black);
			mBTN=new ButtonAS("menu",145,200,120,40,true);
			addChild(mBTN);
			rBTN=new ButtonAS("restart",285,200,120,40,true);
			addChild(rBTN);
			hs=new Hs(275,100);
			addChild(hs);
		}
		public function removeDeath():void {
			mBTN.remove();
			rBTN.remove();
			removeChild(hs);
			removeChild(black);
		}
		public function updateHS(min:uint,sec:uint):void {
			bestTime.updateText(min,sec);
		}
		public var bp:BlackPause = new BlackPause();
		public var tw:ToWhite = new ToWhite();
		public var endHS:EndHS;
		public function addHS():void {
			endHS = new EndHS(275,200);
			addChild(endHS);
		}
		public var upgrade:Upgrade;
		public var b1:UpBTN;
		public var b2:UpBTN;
		public var b3:UpBTN;
		public function doUp():void {
			upgrade = new Upgrade();
			addChild(upgrade);
			b1 = new UpBTN(1,167.5,200);
			b2 = new UpBTN(2,287.5,200);
			b3 = new UpBTN(3,407.5,200);
			addChild(b1);
			addChild(b2);
			addChild(b3);
		}
		public function removeAllUp():void {
			b1.remove();
			b2.remove();
			b3.remove();
			removeChild(b1);
			removeChild(b2);
			removeChild(b3);
			removeChild(upgrade);
		}
		public function toggleMusic():void {
			if(musicOn){
				musicOn=false;
				myChannel.stop();
			} else {
				musicOn=true;
				myChannel = snd.play(0,99);
			}
		}
	}
}