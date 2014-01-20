package com.arc.varzea.entity.object {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	
	public class DoubleJumpOrb extends Collectible {
		public function DoubleJumpOrb(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.DOUBLE_JUMP_ORB, true, false, 16, 16);
			
			if (Registry.doublejump == 1) {
				kill();
			}
		}
		
		override public function collect():void {
			if (Registry.doublejump  == 0) {
				Registry.engine.push(new TextState(Font.REDTEXT, "You've collected the double jump orb! You can now jump a second time while in midair!"));
			}
			
			ArcParticleSystem.emit(Registry.world.particles, "key", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
			Registry.doublejump = 1;
			ArcSfxr.play("pickup");
			kill();
		}
	}
}
