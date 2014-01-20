//par2:Page
package {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Ending extends MovieClip {
		//constants
		private const TRANSITION_FRAME:uint = 100;//can transition frame
		private const LAST_FRAME:uint = 120;
		//variables
		private var par2:MovieClip;
		public function Ending():void {
			stop();
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par2 = MovieClip(parent.parent);
			restart();
			addEventListener(MouseEvent.CLICK,onClick);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		//when the mouse is clicked
		private function onClick(e:MouseEvent):void {
			if(canTransition()) {
				par2.setNextPageLevel(par2.getCurrentLevel());
				par2.gotoNextPage();
			}
		}
		
		//checks if can transition back to the levels
		private function canTransition():Boolean {
			return (currentFrame>=TRANSITION_FRAME);
		}
		
		//restarts the animation
		public function restart():void {
			playEnding();
			updateScoreLabels();
		}
		
		//plays the ending
		private function playEnding():void {
			gotoAndPlay(1);
			mouseEnabled = false;
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {//stop at last frame
			if(currentFrame==90) {
				mouseEnabled = true;
			} else if(currentFrame==LAST_FRAME) {
				stop();
				removeEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
		
		//updates the score labels
		private function updateScoreLabels():void {
			earth.gotoAndStop(1);
			water.gotoAndStop(2);
			air.gotoAndStop(3);
			fire.gotoAndStop(4);
			earth.score.text = String(par2.getMain().getScore().getScore("earth"));
			water.score.text = String(par2.getMain().getScore().getScore("water"));
			air.score.text = String(par2.getMain().getScore().getScore("air"));
			fire.score.text = String(par2.getMain().getScore().getScore("fire"));
			earth.mouseEnabled = false;
			water.mouseEnabled = false;
			air.mouseEnabled = false;
			fire.mouseEnabled = false;
			
			restarts.gotoAndStop(1);
			totalScore.gotoAndStop(2);
			jumps.gotoAndStop(3);
			restarts.score.text = String(par2.getMain().getScore().getRestarts());
			totalScore.score.text = String(par2.getMain().getScore().getTotalScore());
			jumps.score.text = String(par2.getMain().getScore().getJumps());
			restarts.mouseEnabled = false;
			totalScore.mouseEnabled = false;
			jumps.mouseEnabled = false;
			/*
			trace(earthScore,earthScore.text);
			earthScore.text = "22";
			trace(earthScore,earthScore.text);
			*/
			/*
			earthScore.text = String(par2.getMain().getScore().getScore("earth"));
			airScore.text = String(par2.getMain().getScore().getScore("airScore"));
			waterScore.text = String(par2.getMain().getScore().getScore("waterScore"));
			fireScore.text = String(par2.getMain().getScore().getScore("fireScore"));
			*/
			/*
			restarts.text = String(par2.getMain().getScore().getRestarts());
			totalScore.text = String(par2.getMain().getScore().getTotalScore());
			jumps.text = String(par2.getMain().getScore().getJumps());
			*/
		}
	}
}