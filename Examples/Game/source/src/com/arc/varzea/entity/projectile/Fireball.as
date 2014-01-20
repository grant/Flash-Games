package com.arc.varzea.entity.projectile {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.Util;

	public class Fireball extends Spell {
		public function Fireball(x:uint, y:uint, direction:Number, charged:Boolean = false) {
			super(x, y, Resource.FIREBALL);
			loadRotatedGraphic(Resource.FIREBALL, 32, -1, true, true);
			
			this.charged = charged;
			
			offset.x = 7;
			offset.y = 7;
			width *= 0.5;
			height *= 0.5;
			
			this.x -= width / 2;
			this.y -= height / 2;
			
			velocity = Util.d2v(direction, 200);
			angle = Util.r2d(direction);
			
			this.x += velocity.x * 0.03;
			this.y += velocity.y * 0.03;
		}
		
		override public function kill():void {
			ArcParticleSystem.emit(Registry.world.particles, "fireball", getMidpoint().x, getMidpoint().y, contact ? 2 : 15, 1, 1, 400, -50, 50, -50, 50);
			super.kill();
		}
		
		override public function damage():uint {
			if (charged) {
				return 17;
			}
			return 8;
		}
	}
}
