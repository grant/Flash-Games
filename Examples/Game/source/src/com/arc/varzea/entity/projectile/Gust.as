package com.arc.varzea.entity.projectile {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.Util;
	
	public class Gust extends Spell {
		public function Gust(x:uint, y:uint, direction:Number, charged:Boolean = false) {
			super(x, y);
			loadRotatedGraphic(Resource.GUST, 32, -1, true, true);
			
			this.charged = charged;
			
			offset.x = 4;
			offset.y = 4;
			width *= 0.5;
			height *= 0.5;
			
			this.x -= width / 2;
			this.y -= height / 2;
			
			velocity = Util.d2v(direction, charged ? ArcU.rand(150, 350) : 300);
			angle = Util.r2d(direction);
			
			this.x += velocity.x * 0.03;
			this.y += velocity.y * 0.03;
		}
		
		override public function kill():void {
			ArcParticleSystem.emit(Registry.world.particles, "gust", getMidpoint().x, getMidpoint().y, contact ? 3 : 15, 1, 1, 150, -40, 40, -40, 40);
			super.kill();
		}
		
		override public function damage():uint {
			if (charged) {
				return 12;
			}
			return 9;
		}
	}
}
