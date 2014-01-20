/**
 * Controls the birds in the backgrounds
 **/
package background {
	//foreign classes
	import background.Bird;
	//flash classes
	import flash.display.MovieClip;
	public class BirdLayer extends MovieClip {
		private var birds:Array;//stores all birds
		public function BirdLayer():void {
			birds = new Array();
		}
		
		/**
		 * Adds a bird to the screen
		 **/
		public function addBird():void {
			//creates a y position that is in the top 3/4ths of the page but 10 pixels from the very top
			var py:int = (Math.random()*stage.stageHeight*(.75))+10;
			//the size of the bird
			var size:uint = uint(Math.random()*13+5);
			//direction -1 left, 1 right
			var dir:int = Math.round(Math.random());
			dir = (dir===0) ? -1 : 1;//sets direction to -1 if equals 0
			birds.push(new Bird(py,size,dir));
			addChild(birds[birds.length-1]);
		}
		
		/**
		 * Moves all birds
		 **/
		public function moveBirds():void {
			for(var a:uint = 0;a<birds.length;a++) {
				if(birds[a] != null) {
					birds[a].moveBird();
				}
			}
		}
		
		/**
		 * Removes all birds
		 **/
		public function removeAllBirds():void {
			//search through all the bird list and remove a bird if there is a bird
			for(var a:uint = 0;a<birds.length;a++) {
				if(birds[a] != null) {
					removeChild(birds[a]);
				}
			}
		}		
	}
}