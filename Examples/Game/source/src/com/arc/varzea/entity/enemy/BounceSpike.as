package com.arc.varzea.entity.enemy {
	import com.arc.varzea.resource.Resource;
	
	import org.flixel.FlxG;

	public class BounceSpike extends Enemy {
		public function BounceSpike(x:uint, y:uint, d:uint) {
			super(x, y);
			loadGraphic(Resource.BOUNCE_SPIKE, false, false, 13, 13);
			this.x += 2;
			this.y += 2;
			
			walkSpeed = 80;
			killable = false;
			
			go(d);
		}
		
		override public function update():void {
			if (velocity.x == 0 && (facing == LEFT || facing == RIGHT)) {
				go(facing == LEFT ? RIGHT : LEFT);
				//x += velocity.x * FlxG.elapsed;
			} else if (velocity.y == 0 && (facing == UP || facing == DOWN)) {
				go(facing == UP ? DOWN : UP);
				//y += velocity.y * FlxG.elapsed;
			}
		}
	}
}
