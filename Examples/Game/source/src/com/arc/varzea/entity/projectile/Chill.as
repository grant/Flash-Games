package com.arc.varzea.entity.projectile {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.Util;
	
	import org.flixel.FlxG;
	
	public class Chill extends Spell {
		public function Chill(x:uint, y:uint, direction:Number, charged:Boolean) {
			super(x, y);
			loadRotatedGraphic(charged ? Resource.CHARGED_CHILL : Resource.CHILL, 32, -1, true, true);
			
			this.charged = charged;
			
			offset.x = 4;
			offset.y = 4;
			width *= 0.5;
			height *= 0.5;
			
			this.x -= width / 2;
			this.y -= height / 2;
			
			velocity = Util.d2v(direction, 150);
			
			this.x += velocity.x * 0.03;
			this.y += velocity.y * 0.03;
		}
		
		override public function update():void {
			angle += 30;
		}
		
		override public function kill():void {
			ArcParticleSystem.emit(Registry.world.particles, "chill", getMidpoint().x, getMidpoint().y, contact ? 2 : 6, 1, 1, 0, -20, 20, -20, 20);
			if (charged) {
				FlxG.camera.flash(0x33ffffff, 0.2);
				ArcParticleSystem.emit(Registry.world.particles, "chill", getMidpoint().x, getMidpoint().y, contact ? 5 : 20, 1, 1, 0, -200, 200, -200, 200);
			}
			
			super.kill();
		}
		
		override public function damage():uint {
			if (charged) {
				return 17;
			}
			return 5;
		}
	}
}
