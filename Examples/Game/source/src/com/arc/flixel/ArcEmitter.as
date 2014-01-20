package com.arc.flixel {
	import org.flixel.FlxG;
	
	public class ArcEmitter extends ArcSprite {
		private var key:Object = 0;
		public static var interval:Number = 0.05;
		private var num:int = 0;
		private var dur:int = 0;
		private var timer:Number = interval;
		private var minX:Number = -100;
		private var maxX:Number = 100;
		private var minY:Number = -100;
		private var maxY:Number = 100;
		private var grav:Number;
		private var lifetime:Number;
		
		public function ArcEmitter(key:Object, x:int, y:int, num:int, dur:int, lifetime:Number, grav:Number, minX:Number, maxX:Number, minY:Number, maxY:Number, w:int = 0, h:int = 0):void {
			this.key = key;
			this.x = x;
			this.y = y;
			this.num = num;
			this.dur = dur;
			this.grav = grav;
			this.lifetime = lifetime;
			
			this.visible = false;
			
			this.minX = minX;
			this.maxX = maxX;
			this.minY = minY;
			this.maxY = maxY;
			this.width = w;
			this.height = h;
		}
		
		override public function update():void {
			timer += FlxG.elapsed;
			while (timer > interval) {
				timer -= interval;
				dur -= 1;
				ArcParticleSystem.emitterMap[key].setXSpeed(minX, maxX);
				ArcParticleSystem.emitterMap[key].setYSpeed(minY, maxY);
				ArcParticleSystem.emitterMap[key].gravity = grav;
				ArcParticleSystem.emitterMap[key].setSize(width, height);
				ArcParticleSystem.emitParticles(x, y, num, key, lifetime);
			}
			
			if (dur <= 0) {
				this.kill();
			}
		}
	}
}
