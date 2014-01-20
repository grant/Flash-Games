package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Page extends MovieClip {
		private const elementPageFrames:uint = 150;//the number of frames the element title page is on
		
		private var pageName:String;//current page name
		private var nextPageName:String;//next page name

		private var framesToNextPage:int=-1;//number of frames until the transition to the next frame is made
		private var transition:Boolean=false;//if currently transitioning to a frame or not

		private var pageBackground:PageBackground;
		private var pageTransition:PageTransition;
		public function Page(pageName:String):void {
			this.pageName=pageName;
			setPage();
		}

		//sets up the layers of the page
		private function setPage():void {
			addPageBackground();
			addPageTransition();
			addEventListener(Event.ENTER_FRAME,onLoop);
		}

		//adds the page background
		private function addPageBackground():void {
			pageBackground=new PageBackground(pageName);
			addChild(pageBackground);
		}

		//adds the page transition
		private function addPageTransition():void {
			pageTransition = new PageTransition();
			addChild(pageTransition);
		}

		//checks for a transition
		private function onLoop(e:Event):void {
			//key frame checks
			if (framesToNextPage==30) {//waited long enought, start going to black
				toBlack();
			} else if (framesToNextPage==0) {//100% black, moment that switches pages
				pageBackground.gotoPage();
				pageName=nextPageName;//update current page name
				fromBlack();//go to alpha

				//control transitions here
				//once the page is switched, set next page if it is a just a transition page
				//leave blank if transition depends on an external event
				switch (pageName) {
					case "earth page" :
						setNextPage("earth play page");
						gotoNextPage(elementPageFrames);
						break;
					case "earth play page" :
						
						break;
					case "water page" :
						setNextPage("water play page");
						gotoNextPage(elementPageFrames);
						break;
					case "water play page" :
						
						break;
					case "air page" :
						setNextPage("air play page");
						gotoNextPage(elementPageFrames);
						break;
					case "air play page" :
						
						break;
					case "fire page" :
						setNextPage("fire play page");
						gotoNextPage(elementPageFrames);
						break;
					case "fire play page" :
						
						break;
				}
			}

			if (framesToNextPage>=0) {//not -1 (not done)
				framesToNextPage--;
				transition=false;
			}
		}

		//sets the next page
		public function setNextPage(pageName:String):void {
			nextPageName=pageName;
			pageBackground.setNextPage(nextPageName);
		}

		//goes to the next page after x frames
		public function gotoNextPage(frames:uint=30):void {
			framesToNextPage=frames;
			transition=true;
		}

		//changes the transition layer to go from black to alpha
		public function fromBlack():void {
			pageTransition.goFromBlack();
		}

		//changes the transition layer to go from alpha to black
		public function toBlack():void {
			pageTransition.goToBlack();
		}
	}
}