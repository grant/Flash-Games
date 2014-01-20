package com.arc.varzea.entity.object {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	
	public class JumpOrb extends Collectible {
		private var index:uint;
		
		public function JumpOrb(x:uint, y:uint, index:uint) {
			super(x, y);
			loadGraphic(Resource.JUMP_ORB, true, false, 16, 16);
			
			this.index = index;
			if (Registry.jumps[index] == 1) {
				kill();
			}
		}
		
		override public function collect():void {
			if (Registry.numJumps() == 0) {
				Registry.engine.push(new TextState(Font.REDTEXT, "You've collected a jump orb! Each jump orb increases the maximum height you can jump."));
			}
			
			ArcParticleSystem.emit(Registry.world.particles, "key", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
			ArcSfxr.play("pickup");
			Registry.jumps[index] = 1;
			kill();
		}
	}
}
