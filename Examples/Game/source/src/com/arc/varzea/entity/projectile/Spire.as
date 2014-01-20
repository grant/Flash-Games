package com.arc.varzea.entity.projectile {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.Util;
	
	public class Spire extends Spell {
		public function Spire(x:uint, y:uint, direction:Number, charged:Boolean = false) {
			super(x, y, Resource.SPIRE);
			loadRotatedGraphic(Resource.SPIRE, 32, -1, true, true);
			
			this.charged = charged;
			
			offset.x = 7;
			offset.y = 7;
			width *= 0.5;
			height *= 0.7;
			
			this.x -= width / 2;
			this.y -= height / 2;
			
			velocity = Util.d2v(direction, charged ? 180 : 140);
			angle = Util.r2d(direction);
			
			this.x += velocity.x * 0.03;
			this.y += velocity.y * 0.03;
		}
		
		override public function kill():void {
			ArcParticleSystem.emit(Registry.world.particles, "spire", getMidpoint().x, getMidpoint().y, contact ? 2 : 5, 1, 1, 300, -20, 20, -20, 20);
			super.kill();
		}
		
		override public function damage():uint {
			if (charged) {
				return 15;
			}
			return 8;
		}
	}
}
