package com.arc.varzea.entity.object {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	
	public class SpeedOrb extends Collectible {
		private var index:uint;
		
		public function SpeedOrb(x:uint, y:uint, index:uint) {
			super(x, y);
			loadGraphic(Resource.SPEED_ORB, true, false, 16, 16);
			
			this.index = index;
			if (Registry.speeds[index] == 1) {
				kill();
			}
		}
		
		override public function collect():void {
			if (Registry.numSpeeds() == 0) {
				Registry.engine.push(new TextState(Font.REDTEXT, "You've collected a speed orb! Each jump orb increases the maximum speed you can run."));
			}
			ArcParticleSystem.emit(Registry.world.particles, "key", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
			ArcSfxr.play("pickup");
			Registry.speeds[index] = 1;
			kill();
		}
	}
}
