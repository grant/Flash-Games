package com.arc.varzea.entity.object {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;

	public class HeartOrb extends Collectible {
		private var index:uint;
		
		public function HeartOrb(x:uint, y:uint, index:uint) {
			super(x, y);
			loadGraphic(Resource.HEART_ORB, true, false, 16, 16);
			
			this.index = index;
			if (Registry.hearts[index] == 1) {
				kill();
			}
		}
		
		override public function collect():void {
			if (Registry.numHearts() == 0) {
				Registry.engine.push(new TextState(Font.REDTEXT, "You've collected a heart orb! Each heart orb increases your maximum health."));
			}
			ArcParticleSystem.emit(Registry.world.particles, "key", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
			ArcSfxr.play("pickup");
			Registry.hearts[index] = 1;
			kill();
		}
	}
}
