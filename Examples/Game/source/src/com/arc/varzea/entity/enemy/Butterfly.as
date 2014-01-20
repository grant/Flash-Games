package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class Butterfly extends Enemy {
		private static const SHOOT_DELAY:Number = 4;
		private var shootTimer:Number = ArcU.rand(0, SHOOT_DELAY * 10) / 10;
		
		public function Butterfly(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.BUTTERFLY, true, false, 16, 10);
			this.y += Tile.HEIGHT - height;
			addAnimation("wiggle", [0, 1, 2, 1], 5);
			play("wiggle");
			
			hp = 30;
		}
		
		override public function update():void {
			shootTimer -= FlxG.elapsed;
			if (shootTimer <= 0) {
				shootTimer = ArcU.rand(SHOOT_DELAY * 10 / 2, SHOOT_DELAY * 10) / 10;
				shoot();
			}
			
			super.update();
		}
		
		private function shoot():void {
			var midpoint:FlxPoint = getMidpoint();
			var tx:Number = (midpoint.x - 3) / Tile.WIDTH;
			var ty:Number = (midpoint.y - 4) / Tile.HEIGHT;
			
			Registry.world.objects.add(new Bullet(tx + 0.5, ty, 0, 50));
			Registry.world.objects.add(new Bullet(tx - 0.5, ty, Math.PI, 50));
		}
	}
}
