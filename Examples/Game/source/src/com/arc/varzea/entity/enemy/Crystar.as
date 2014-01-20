package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class Crystar extends Enemy {
		private static const SHOOT_DELAY:Number = 3;
		private var shootTimer:Number = ArcU.rand(0, SHOOT_DELAY * 10) / 10;
		
		public function Crystar(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.CRYSTAR, true, false, 17, 11);
			this.y -= 3;
			addAnimation("shine", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2, 1], 5);
			play("shine");
			
			immovable = true;
			hp = 30;
		}
		
		override public function update():void {
			shootTimer -= FlxG.elapsed;
			if (shootTimer <= 0) {
				shootTimer = ArcU.rand(SHOOT_DELAY * 10 / 2, SHOOT_DELAY * 10) / 10;
				trace(shootTimer);
				shoot();
			}
			
			super.update();
		}
		
		private function shoot():void {
			var midpoint:FlxPoint = getMidpoint();
			var tx:Number = (midpoint.x - 3) / Tile.WIDTH;
			var ty:Number = (midpoint.y - 4) / Tile.HEIGHT;
			
			Registry.world.objects.add(new Bullet(tx, ty + 0.25, Math.atan2(Registry.world.player.midpoint.y - midpoint.y, Registry.world.player.midpoint.x - midpoint.x), 80));
		}
	}
}
