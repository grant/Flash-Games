package com.arc.flixel {
	import org.flixel.FlxEmitter;
	public class ArcParticleSystem {
		public static var emitterMap:Object = new Object;
		public static var emitterGroup:ArcEmitterGroup = new ArcEmitterGroup;
		
		public static function registerEmitter(key:Object, graphic:Class, quantity:int = 100, multiple:Boolean = false):void {
			if (emitterMap[key] != null) return;
			
			var emitter:FlxEmitter = new FlxEmitter;
			emitter.makeParticles(graphic, quantity, 0, multiple);
			emitter.setRotation();
			emitterMap[key] = emitter;
			emitterGroup.add(emitter);
		}
		
		public static function emit(group:ArcGroup, key:Object, x:int, y:int, num:int, dur:int, lifetime:Number = 1.0, grav:Number = 400, minX:Number = -100, maxX:Number = 100, minY:Number = -100, maxY:Number = 100, w:int = 0, h:int = 0 ):void {
			var emitter:ArcEmitter = new ArcEmitter(key, x, y, num, dur, lifetime, grav, minX, maxX, minY, maxY, w, h);
			group.add(emitter);
		}
		
		public static function get emitters():ArcGroup {
			return emitterGroup;
		}
		
		public static function emitParticles(x:int, y:int, num:int, key:Object, lifetime:Number):void {
			//ArcParticleSystem.lifetime = lifetime;
			emitterMap[key].x = x;
			emitterMap[key].y = y;
			emitterMap[key].lifespan = lifetime;
			while (num-- > 0) {
				emitterMap[key].emitParticle();
			}
		}
	}
}
