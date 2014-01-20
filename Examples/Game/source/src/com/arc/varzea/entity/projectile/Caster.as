package com.arc.varzea.entity.projectile {
	import com.arc.flixel.ArcSfxr;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.entity.Player;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.Util;
	
	import org.flixel.FlxPoint;

	public class Caster {
		public static function cast(player:Player):void {
			switch(player.spell) {
				case Spell.FIREBALL: fireball(player); break;
				case Spell.CHILL: chill(player); break;
				case Spell.DOUSE: douse(player); break;
				case Spell.GUST: gust(player); break;
				case Spell.SHOCK: shock(player); break;
				case Spell.SPIRE: spire(player); break;
			}
		}
		
		private static function fireball(player:Player):void {
			if (!Registry.fireball) {
				return;
			}
			ArcSfxr.play("cast");
			
			var spell:Spell = new Fireball(player.midpoint.x, player.midpoint.y, player.direction, player.charge.charged);
			add(spell);
			
			if (player.charge.charged) {
				spell = new Fireball(player.midpoint.x, player.midpoint.y, player.direction - 0.15);
				add(spell);
				
				spell = new Fireball(player.midpoint.x, player.midpoint.y, player.direction + 0.15);
				add(spell);
			}
		}
		
		private static function chill(player:Player):void {
			if (!Registry.chill) {
				return;
			}
			ArcSfxr.play("cast");
			
			var spell:Spell = new Chill(player.midpoint.x, player.midpoint.y, player.direction, player.charge.charged);
			add(spell);
		}
		
		private static function douse(player:Player):void {
			if (!Registry.douse) {
				return;
			}
			ArcSfxr.play("cast");
			
			var count:uint = player.charge.charged ? 10 : 5;
			for (var i:uint = 0; i < count; i++) {
				var spell:Spell = new Douse(player.midpoint.x, player.midpoint.y, player.direction + ArcU.rand(-40, 40) / 100, player.charge.charged);
				add(spell);
			}
		}
		
		private static function gust(player:Player):void {
			if (!Registry.gust) {
				return;
			}
			ArcSfxr.play("cast");
			
			var spell:Spell = new Gust(player.midpoint.x, player.midpoint.y, player.direction, player.charge.charged);
			add(spell);
			
			if (player.charge.charged) {
				for (var i:uint = 0; i < 3; i++) {
					spell = new Gust(player.midpoint.x, player.midpoint.y, player.direction, player.charge.charged);
					add(spell);
				}
			}
		}
		
		private static function shock(player:Player):void {
			if (!Registry.shock) {
				return;
			}
			ArcSfxr.play("cast");
			
			var count:uint = player.charge.charged ? 10 : 4;
			var range:uint = player.charge.charged ? 314 : 40;
			for (var i:uint = 0; i < count; i++) {
				var spell:Spell = new Shock(player.midpoint.x, player.midpoint.y, player.direction + ArcU.rand(-range, range) / 100, player.charge.charged);
				add(spell);
			}
		}
		
		private static function spire(player:Player):void {
			if (!Registry.spire) {
				return;
			}
			ArcSfxr.play("cast");
			
			var spell:Spell;
			
			if (player.charge.charged) {
				var sideways:Number = player.direction + Math.PI / 2;
				var sideways2:Number = player.direction + Math.PI / 2 * -1;
				spell = new Spire(player.midpoint.x + Math.cos(sideways) * 5, player.midpoint.y + Math.sin(sideways) * 5, player.direction, player.charge.charged);
				add(spell);
				spell = new Spire(player.midpoint.x + Math.cos(sideways2) * 5, player.midpoint.y + Math.sin(sideways2) * 5, player.direction, player.charge.charged);
				add(spell);
			}
			
			spell = new Spire(player.midpoint.x, player.midpoint.y, player.direction, player.charge.charged);
			add(spell);
		}
		
		private static function add(spell:Spell):void {
			Registry.world.projectiles.add(spell);
		}
	}
}
