package {
	import flash.display.MovieClip;
	public class Unlocked extends MovieClip {
		private var levelsUnlocked:uint = 1;
		public function Unlocked():void {
			
		}
		
		//sets the levels unlocked
		public function setLevelsUnlocked(levels:uint):void {
			levelsUnlocked = levels;
		}
		
		//get levels unlocked
		public function getLevelsUnlocked():uint {
			return levelsUnlocked;
		}
	}
}