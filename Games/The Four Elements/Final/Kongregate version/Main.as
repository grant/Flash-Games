package {
	import flash.display.MovieClip;
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.Security;
	public class Main extends MovieClip {
		private var score:Scores;
		private var musicPlayer:MusicPlayer;
		private var page:Page;
		
		private var kongregate:*;// Kongregate API reference
		private var kongregateGood:Boolean = false;
		public function Main():void {
			addScores();
			addPage();
			addMusic();
			setMenu();
			addKongregate();
		}

		//add a high score
		private function addScores():void {
			score = new Scores();
			addChild(score);
		}

		//starts the game from the title screen
		private function addPage():void {
			page=new Page("title screen");
			page.fromBlack();
			page.setNextPage("earth page");
			page.gotoNextPage(130);
			addChild(page);
		}

		//adds music
		private function addMusic():void {
			musicPlayer=new MusicPlayer(this.loaderInfo.loaderURL);
		}

		//adds kongregate api
		private function addKongregate():void {
			// Pull the API path from the FlashVars
			var paramObj:Object=LoaderInfo(root.loaderInfo).parameters;

			// The API path. The "shadow" API will load if testing locally. 
			var apiPath:String = paramObj.kongregate_api_path || 
			  "http://www.kongregate.com/flash/API_AS3_Local.swf";

			// Allow the API access to this SWF
			Security.allowDomain(apiPath);

			// Load the API
			var request:URLRequest=new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			this.addChild(loader);

			// This function is called when loading is complete
			function loadComplete(event:Event):void {
				// Save Kongregate API reference
				kongregate=event.target.content;

				// Connect to the back-end
				kongregate.services.connect();
				
				kongregateGood = true;
				
				// You can now access the API via:
				// kongregate.services
				// kongregate.user
				// kongregate.scores
				// kongregate.stats
				// etc...
			}
		}

		//sets up the right click menu
		private function setMenu():void {
			stage.showDefaultContextMenu=false;
		}

		//gets the score
		public function getScore():Scores {
			return score;
		}

		//gets the page
		public function getPage():Page {
			return page;
		}

		//gets the music player
		public function getMusicPlayer():MusicPlayer {
			return musicPlayer;
		}
		
		//adds a kongregate score
		public function addKongScore(scoreName:String,score:uint):void {
			kongregate.stats.submit(scoreName,score);
		}
	}
}