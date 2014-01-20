package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.entity.projectile.Douse;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	public class Fire extends Enemy {
		public function Fire(x:uint, y:uint) {
			super(x, y);
			loadRotatedGraphic(Resource.FIRE, 32, -1, true, true);
			
			barrier = true;
		}
		
		override public function update():void {
			angle += 20;
			super.update();
		}
		
		override public function hit(spell:Spell):void {
			if (spell is Douse) {
				kill();
			}
		}
		
		override public function deathEmit():void {
			ArcParticleSystem.emit(Registry.world.particles, "douse", getMidpoint().x, getMidpoint().y, 10, 2, 1, 00, -40, 40, -40, 40);
		}
	}
}
