package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.entity.Entity;
	import com.arc.varzea.entity.projectile.Douse;
	import com.arc.varzea.entity.projectile.Shock;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxObject;
	
	public class Lever extends Enemy {
		private var activated:Boolean = false;
		
		public function Lever(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.LEVER, true, false, 16, 16);
			frame = 0;
			
			killable = false;
			harmful = false;
		}
		
		override public function hit(spell:Spell):void {
			if (spell is Shock) {
				if (!activated) {
					for each(var object:FlxObject in Registry.world.objects.members) {
						if (object is SlidingDoor) {
							(object as SlidingDoor).slide();
						}
					}
					frame = 1;
					activated = true;
				}
			}
			
			super.hit(spell);
		}
		
		override public function deathEmit():void {
			ArcParticleSystem.emit(Registry.world.particles, "douse", getMidpoint().x, getMidpoint().y, 10, 2, 1, 00, -40, 40, -40, 40);
		}
	}
}
