package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.Util;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxPoint;
	
	public class Bullet extends Enemy {
		private var initialVelocity:FlxPoint = new FlxPoint;
		
		public function Bullet(x:Number, y:Number, direction:Number, speed:Number) {
			super(x, y);
			loadRotatedGraphic(Resource.BULLET, 32, -1, true, true);
			width = height = 2;
			offset.x = offset.y = 5;
			velocity = Util.d2v(direction, speed);
			initialVelocity.x = velocity.x;
			initialVelocity.y = velocity.y;
		}
		
		override public function hit(spell:Spell):void {
			
		}
		
		override public function update():void {
			if (velocity.x < 0) {
				angle -= 10;
			} else {
				angle += 10;
			}
			
			if (velocity.x != initialVelocity.x || velocity.y != initialVelocity.y) {
				kill();
			}
			
			super.update();
		}
		
		override public function deathEmit():void {
			ArcParticleSystem.emit(Registry.world.particles, "red", getMidpoint().x, getMidpoint().y, 4, 1, 1, 00, -20, 20, -20, 20);
		}
	}
}
