package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.entity.Entity;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;

	public class Enemy extends Entity {
		protected var walkSpeed:Number = 50;
		public var killable:Boolean = true;
		public var harmful:Boolean = true;
		public var barrier:Boolean = false;
		
		public function Enemy(x:Number, y:Number) {
			super(x, y);
		}
		
		public function go(direction:uint):void {
			if (direction == LEFT) {
				velocity.x = -walkSpeed;
			} else if (direction == RIGHT) {
				velocity.x = walkSpeed;
			} else if (direction == UP) {
				velocity.y = -walkSpeed;
			} else if (direction == DOWN) {
				velocity.y = walkSpeed;
			}
			facing = direction;
		}
			
		override public function kill():void {
			deathEmit();
			super.kill();
		}
		
		public function deathEmit():void {
			ArcParticleSystem.emit(Registry.world.particles, "red", getMidpoint().x, getMidpoint().y, 10, 2, 1, 00, -40, 40, -40, 40);
		}
		
		private var lostHP:int = 0;
		override public function hit(spell:Spell):void {
			spell.contact = true;
			spell.kill();
			
			if (!killable) {
				return;
			}
			
			var damage:Number = Math.ceil(spell.damage() * ArcU.rand(8, 12) / 10);
			damage *= (1 + Registry.level / 25);
			damage = Math.ceil(damage);
			
			Registry.world.texts.add(new DamageText(getMidpoint().x, getMidpoint().y, damage.toString()));
			
			lostHP += damage;
			hp -= damage;
			if (hp <= 0) {
				lostHP += hp; // if it's negative, take it out
				if (harmful && !barrier && killable) {
					Registry.experience(lostHP);
				}
				
				Registry.world.spawnMap.despawn(spawnX, spawnY);
				kill();
				ArcSfxr.play("killenemy");
			} else {
				flash(0x660000, 0.06);
				ArcSfxr.play("hitenemy");
			}
		}
	}
}
