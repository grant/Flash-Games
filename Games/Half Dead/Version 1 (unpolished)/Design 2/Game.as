package {
	import flash.display.MovieClip;
	public class Game extends MovieClip {

		public var bullets:Array = new Array();
		public var bulletNumber:uint = 0;
		public var shells:Array = new Array();
		public var shellNumber:uint = 0;
		public var deadBullets:Array = new Array();
		public var deadBulletNumber:uint = 0;
		public var shootingFires:Array = new Array();
		public var shootingFireNumber:uint = 0;
		
		public var char:Character;
		public var groundHolder:Array = new Array();
		public var ground:Number = 300;
		public function Game() {
			//x, y, width, height
			groundHolder[0] = new Ground(100,300,230,200);
			groundHolder[1] = new Ground(300,200,300,400);
			groundHolder[2] = new Ground(0,0,200,40);
			groundHolder[3] = new Ground(-300,400,400,400);
			groundHolder[4] = new Ground(600,500,400,100);
			for(var i:uint=0;i<groundHolder.length;i++){
				addChild(groundHolder[i]);
			}
			char = new Character(200,200);
			addChild(char);					
		}
	}
}