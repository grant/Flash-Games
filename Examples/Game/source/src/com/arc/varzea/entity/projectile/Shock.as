package com.arc.varzea.entity.projectile {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.Util;
	
	import org.flixel.FlxG;
	
	public class Shock extends Spell {
		private var speed:Number;
		private var direction:Number;
		
		public function Shock(x:uint, y:uint, direction:Number, charged:Boolean) {
			super(x, y);
			loadGraphic(Resource.SHOCK, true, false, 10, 10);
			
			this.charged = charged;
			
			offset.x = 2;
			offset.y = 2;
			width = 6;
			height = 6;
			
			this.x -= width / 2;
			this.y -= height / 2;
			
			this.speed = 100;
			this.direction = direction;
			velocity = Util.d2v(direction, speed);
			
			this.x += velocity.x * 0.03;
			this.y += velocity.y * 0.03;
			
			addAnimation("shock", [0, 1, 2, 3, 2, 1], 10, true);
			play("shock");
		}
		
		override public function update():void {
			/*if (ArcU.rand(0, 10) == 5) {
				velocity.x += ArcU.rand(-20, 20);
			}
			if (ArcU.rand(0, 10) == 5) {
				velocity.y += ArcU.rand(-20, 20);
			}*/
			
			if (ArcU.rand(0, 10) == 5) {
				direction += ArcU.rand(-10, 10) / 20;
				velocity = Util.d2v(direction, speed);
			}
		}
		
		override public function kill():void {
			ArcParticleSystem.emit(Registry.world.particles, "shock", getMidpoint().x, getMidpoint().y, 2, 1, 1, 0, -20, 20, -20, 20);
			
			super.kill();
		}
		
		override public function damage():uint {
			if (charged) {
				return 18;
			}
			return 3;
		}
	}
}
