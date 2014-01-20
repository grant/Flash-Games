//par:Main
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Page extends MovieClip {
		private const elementPageFrames:uint = 150;//the number of frames the element title page is on
		
		private var pageName:String;//current page name
		private var nextPageName:String;//next page name

		private var framesToNextPage:int=-1;//number of frames until the transition to the next frame is made
		private var transition:Boolean=false;//if currently transitioning to a frame or not

		private var levelsUnlocked:uint = 1;
		private var currentLevel:uint = 1;//same as element id of other classes
		
		private var gameWon:Boolean = false;//if the game has been won or not
		private var seenScores:Boolean = false;//if the user has seen the score screen

		//display layers
		private var pageBackground:PageBackground;
		
		private var scoreBoard:ScoreBoard;//score board
		private var game:Game;//game
		private var pageGameLayer:MovieClip;
		
		private var unlockingLabel:CustomLabel;
		private var instructionLabel:CustomLabel;
		private var scoreButton:ScoreButton;
		private var pageLabelLayer:MovieClip;
		
		private var pageTransition:PageTransition;
		
		//parent
		private var par:MovieClip;
		public function Page(pageName:String):void {
			this.pageName=pageName;
			setPage();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}

		//Setting up page:
		//sets up the layers of the page
		private function setPage():void {
			addPageBackground();
			addPageGameLayer();
			addLabelLayer();
			addPageTransition();
			addEventListener(Event.ENTER_FRAME,onLoop);
		}

		//adds the page background
		private function addPageBackground():void {
			pageBackground=new PageBackground(pageName);
			addChild(pageBackground);
		}

		//add the page game layer
		private function addPageGameLayer():void {
			pageGameLayer = new MovieClip();
			addChild(pageGameLayer);
		}
		
		//add the page label layer
		private function addLabelLayer():void {
			pageLabelLayer = new MovieClip();
			addChild(pageLabelLayer);
		}

		//add lables
		private function addLabels():void {
			if(currentLevel==2) {
				unlockingLabel = new CustomLabel(2,true);
			} else if(currentLevel==1||currentLevel==3) {
				unlockingLabel = new CustomLabel(4,true);
			} else {
				unlockingLabel = new CustomLabel(5,true);
			}
			unlockingLabel.x = 440;
			unlockingLabel.y = 25;
			unlockingLabel.setDisappear();
			pageLabelLayer.addChild(unlockingLabel);
			
			instructionLabel = new CustomLabel(3,true);
			if(currentLevel==1&&par.getScore().getScore("earth")>=30) {//if on the first level and the score is greater or equal to 30
				instructionLabel.x = 630;
				instructionLabel.y = 200;
				instructionLabel.setDisappearTime(99999);//make auto-disappear time pend a long time
				//fixes alpha = 1 glitch
				instructionLabel.setDisappear();
				instructionLabel.appear();
			} else {
				instructionLabel.setDisappear();
			}
			pageLabelLayer.addChild(instructionLabel);
			
			scoreButton = new ScoreButton(741,577);
			if(!seenScores) {
				scoreButton.disappear();
			}
			pageLabelLayer.addChild(scoreButton);
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
						currentLevel = 1;
						removeComponents();
						setNextPage("earth play page");
						gotoNextPage(elementPageFrames);
						par.getMusicPlayer().stopMusic();
						par.getMusicPlayer().playMusic("earth");
						break;
					case "earth play page" :
						addGame("earth");
						break;
					case "water page" :
						currentLevel = 2;
						removeComponents();
						setNextPage("water play page");
						gotoNextPage(elementPageFrames);
						par.getMusicPlayer().stopMusic();
						par.getMusicPlayer().playMusic("water");
						break;
					case "water play page" :
						addGame("water");
						break;
					case "air page" :
						currentLevel = 3;
						removeComponents();
						setNextPage("air play page");
						gotoNextPage(elementPageFrames);
						par.getMusicPlayer().stopMusic();
						par.getMusicPlayer().playMusic("air");
						break;
					case "air play page" :
						addGame("air");
						break;
					case "fire page" :
						currentLevel = 4;
						removeComponents();
						setNextPage("fire play page");
						gotoNextPage(elementPageFrames);
						par.getMusicPlayer().stopMusic();
						par.getMusicPlayer().playMusic("fire");
						break;
					case "fire play page" :
						addGame("fire");
						break;
					case "scores" :
						removeComponents();
						if(!seenScores) {
							seenScores = true;
							pageBackground.endFrame.restart();
						}
				}
			}

			if (framesToNextPage>=0) {//not -1 (not done)
				framesToNextPage--;
				transition=false;
			}
		}

		//Page changes:
		//-setNextPage(name:String)
		//-gotoNextPage(waitNumFrames:uint)
		//sets the next page
		public function setNextPage(pageName:String):void {
			nextPageName=pageName;
			pageBackground.setNextPage(nextPageName);
		}
		
		//sets next page via level number
		public function setNextPageLevel(level:uint):void {
			switch(level) {
				case 1:
					setNextPage("earth play page");
					break;
				case 2:
					setNextPage("water play page");
					break;
				case 3:
					setNextPage("air play page");
					break;
				case 4:
					setNextPage("fire play page");
					break;
			}
		}
		
		//goes to the next page after x frames
		public function gotoNextPage(frames:uint=30):void {
			framesToNextPage=frames;
			transition=true;
		}

		//Transitions:
		//-fromBlack()
		//-toBlack()
		//changes the transition layer to go from black to alpha
		public function fromBlack():void {
			pageTransition.goFromBlack();
		}

		//changes the transition layer to go from alpha to black
		public function toBlack():void {
			pageTransition.goToBlack();
		}
		
		//adds a game to the page
		public function addGame(gameName:String):void {
			scoreBoard = new ScoreBoard(60,40);
			pageGameLayer.addChild(scoreBoard);
			game = new Game(gameName,levelsUnlocked);
			addLabels();
			pageGameLayer.addChild(game);
		}
		
		//adds the score board to the screen
		private function addScoreBoard():void {
			scoreBoard = new ScoreBoard(60,40);
			addChild(scoreBoard);
		}
		
		//gets the high score
		public function getScore():Scores {
			return par.getScore();
		}
		
		//gets the score board
		public function getScoreBoard():ScoreBoard {
			return scoreBoard;
		}
		
		//update levels uplocked
		public function updateLevelsUnlocked(levels:uint):void {
			if(levels==5) {
				scoreButton.appear();
				seenScores = true;
			}
			levelsUnlocked = levels;
			game.getSelectionWheel().updateLevelsUnlocked(levelsUnlocked);
		}
		
		//gets the number of levels unlocked
		public function getLevelsUnlocked():uint {
			return levelsUnlocked;
		}
		
		//gets the current level
		public function getCurrentLevel():uint {
			return currentLevel;
		}
		
		//gets the unlocking label
		public function getUnlockingLabel():CustomLabel {
			return unlockingLabel;
		}
		
		//removes all the page components
		private function removeComponents():void {
			if(scoreBoard!=null) {//if a game has been set up yet
				//remove all parts of the game
				scoreBoard.remove();
				game.remove();
				unlockingLabel.remove();
				instructionLabel.remove();
				if(scoreBoard!=null) {
					scoreButton.remove();
				}
			}
		}
		
		//gets the instruction label
		public function getInstructionLabel():CustomLabel {
			return instructionLabel;
		}
		
		//gets the main
		public function getMain():MovieClip {
			return par;
		}
		
		//goes to the score page
		public function gotoScores():void {
			setNextPage("scores");
			gotoNextPage();
		}
	}
}