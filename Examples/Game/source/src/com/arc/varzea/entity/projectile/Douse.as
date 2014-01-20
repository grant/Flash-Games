package com.arc.varzea.entity.projectile {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.Util;
	
	import org.flixel.FlxG;
	
	public class Douse extends Spell {
		private var lifetime:Number = 0.5;
		private var speed:uint = 150;
		
		public function Douse(x:uint, y:uint, direction:Number, charged:Boolean = false) {
			super(x, y, Resource.DOUSE);
			
			this.charged = charged;
			if (charged) {
				lifetime = 5;
				speed = 250;
			}
			
			offset.x = 4;
			offset.y = 4;
			width *= 0.5;
			height *= 0.5;
			
			this.x -= width / 2;
			this.y -= height / 2;
			
			velocity = Util.d2v(direction, speed * ArcU.rand(80, 120) / 100);
			acceleration.y = 300;
			
			this.x += velocity.x * (ArcU.rand(0, 50) / 1000);
			this.y += velocity.y * (ArcU.rand(0, 50) / 1000);
		}
		
		override public function update():void {
			lifetime -= FlxG.elapsed;
			if (lifetime <= 0) {
				kill();
			}
		}
		
		override public function kill():void {
			if (lifetime <= 0) {
				ArcParticleSystem.emit(Registry.world.particles, "douse", x, y, 3, 1, 1, 0, -30, 30, -30, 30, width, height);				
			} else {
				ArcParticleSystem.emit(Registry.world.particles, "douse", getMidpoint().x, getMidpoint().y, contact ? 2 : 3, 1, 1, 400, -50, 50, -50, 50);
			}
			super.kill();
		}
		
		override public function damage():uint {
			if (charged) {
				return 9;
			}
			return 3;
		}
	}
}
