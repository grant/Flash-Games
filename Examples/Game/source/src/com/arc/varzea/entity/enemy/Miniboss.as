package com.arc.varzea.entity.enemy {
	import com.arc.varzea.entity.object.Key;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	
	import org.flixel.FlxG;
	
	public class Miniboss extends Enemy {
		private var hfacing:uint = RIGHT;
		private var vfacing:uint = DOWN;
		
		private var tx:uint, ty:uint;
		
		private static const MAX_HP:int = 600;
		
		public function Miniboss(x:uint, y:uint) {
			this.tx = x;
			this.ty = y;
			
			super(x, y);
			loadGraphic(Resource.MINIBOSS, false, false, 19, 19);
			this.x -= 2;
			this.y -= 2;
			
			trace("Spawned at", tx, ty, x, y, this.x, this.y);
			
			addAnimation("green", [0]);
			addAnimation("yellow", [1]);
			addAnimation("red", [2]);

			hp = MAX_HP;
			
			walkSpeed = 80;
			
			go(vfacing);
			go(hfacing);
			
			if (Registry.miniboss == 1) {
				kill();
			}
		}
		
		override public function update():void {
			if (velocity.x == 0) {
				go(hfacing == LEFT ? RIGHT : LEFT);
				hfacing = facing;
			} else if (velocity.y == 0) {
				go(vfacing == UP ? DOWN : UP);
				vfacing = facing;
			}
			
			if (hp > MAX_HP * 2 / 3) {
				play("green");
			} else if (hp > MAX_HP / 3) {
				play("yellow");
			} else {
				play("red");
			}
			
			super.update();
		}
		
		override public function kill():void {			
			if (hp <= 0) {
				// spawn key
				var key:Key = new Key(tx, ty, 1);
				Registry.world.objects.add(key);
				
				Registry.miniboss = 1;
			}
			
			super.kill();
		}
	}
}
