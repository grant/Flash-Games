package com.arc.varzea.util {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.varzea.resource.Resource;

	public class ParticleSystem {
		private static var initialized:Boolean = false;
		
		public static function initialize():void {
			if (initialized) {
				return;
			}
			
			ArcParticleSystem.registerEmitter("charge", Resource.PARTICLE_CHARGE, 40, true);
			
			ArcParticleSystem.registerEmitter("fireball", Resource.PARTICLE_FIREBALL, 100, true);
			ArcParticleSystem.registerEmitter("chill", Resource.PARTICLE_CHILL, 100, true);
			ArcParticleSystem.registerEmitter("douse", Resource.PARTICLE_DOUSE, 100, true);
			ArcParticleSystem.registerEmitter("gust", Resource.PARTICLE_GUST, 100, true);
			ArcParticleSystem.registerEmitter("shock", Resource.PARTICLE_SHOCK, 100, true);
			ArcParticleSystem.registerEmitter("spire", Resource.PARTICLE_SPIRE, 100, true);
			
			ArcParticleSystem.registerEmitter("red", Resource.PARTICLE_RED, 100, true);
			ArcParticleSystem.registerEmitter("key", Resource.PARTICLE_KEY, 100, true);
			
			initialized = true;
		}
	}
}
