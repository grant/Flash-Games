package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	public class Slime extends Enemy {
		public function Slime(x:uint, y:uint) {
			super(x, y);
		}
		
		protected function initialize():void {
			var color:uint = ArcU.rand(0, 7) * 3;
			addAnimation("walk", [color + 0, color + 1, color + 2, color + 1], 5);
			play("walk");
			go(ArcU.rand(0, 1) == 0 ? RIGHT : LEFT);
		}
		
		override public function update():void {
			var tx:int = x / Tile.WIDTH + (velocity.x > 0 ? 1 : 0);
			var ty:int = y / Tile.HEIGHT + 1;
			var tileid:uint = Registry.world.world.getTile(tx, ty);
			if (tileid == 0) {
				if (velocity.x < 0) {
					go(RIGHT);
				} else {
					go(LEFT);
				}
			} else if (velocity.x == 0) {
				go(facing == LEFT ? RIGHT : LEFT);
			}
			
			super.update();
		}
	}
}
