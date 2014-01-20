package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.entity.projectile.Douse;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxG;
	
	public class Kitty extends Enemy {		
		public function Kitty(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.KITTY, true, false, 15, 14);
			killable = false;
			this.y += 2;
			
			addAnimation("wag", [0, 1, 2, 3, 2, 1], 5);
			play("wag");
			
			immovable = true;
			harmful = false;
		}
		
		override public function update():void {
			if (Registry.numHearts() == 5 && Registry.numJumps() == 5 && Registry.numSpeeds() == 5) {
				killable = true;
			}
			
			super.update();
		}
		
		override public function deathEmit():void {
			ArcParticleSystem.emit(Registry.world.particles, "key", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
		}
	}
}
