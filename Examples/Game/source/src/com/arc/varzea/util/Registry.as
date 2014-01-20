package com.arc.varzea.util {
	import com.arc.varzea.engine.GameEngine;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.engine.WorldState;
	import com.arc.varzea.entity.enemy.LevelUpText;
	import com.arc.varzea.entity.object.SaveCrystal;
	import com.arc.varzea.resource.Font;

	public class Registry {
		public static var engine:GameEngine;
		public static var world:WorldState;
		
		public static var fireball:Boolean = false;
		public static var douse:Boolean = false;
		public static var chill:Boolean = false;
		public static var shock:Boolean = false;
		public static var spire:Boolean = false;
		public static var gust:Boolean = false;
		
		public static var keys:Array = [0, 0, 0, 0, 0, 0];
		public static var doublejump:int = 0;
		
		public static var miniboss:int = 0;
		
		public static var time:Number = 0;
		
		public static var BASE_HP:int = 3;
		public static var hp:int = BASE_HP;
		public static var hearts:Array = [0, 0, 0, 0, 0];
		public static var jumps:Array = [0, 0, 0, 0, 0];
		public static var speeds:Array = [0, 0, 0, 0, 0];
		public static var save:Array = [0, 0];
		
		public static var sound:int = 1;
		public static var music:int = 1;
		
		public static var level:int = 1;
		public static var xp:int = 0;
		public static var xpm:int = 50;
		
		public static function resetHP():void {
			hp = maxHP();
		}
		
		public static function maxHP():int {
			return BASE_HP + hearts[0] + hearts[1] + hearts[2] + hearts[3] + hearts[4];
		}
		
		public static function reset():void {
			fireball = false;
			douse = false;
			chill = false;
			shock = false;
			spire = false;
			gust = false;
			
			keys = [0, 0, 0, 0, 0, 0];
			doublejump = 0;
			
			miniboss = 0;

			time = 0;
			
			hp = 3;
			hearts = [0, 0, 0, 0, 0];
			jumps = [0, 0, 0, 0, 0];
			speeds = [0, 0, 0, 0, 0];
			
			SaveCrystal.current.x = 0;
			SaveCrystal.current.y = 0;
			save = [0, 0];
			
			//sound = 1;
			//music = 1;
			
			level = 1;
			xp = 0;
			xpm = 50;
		}
		
		public static function experience(amount:uint):void {
			if (level >= 50) {
				xp = 0;
				level = 50;
				return;
			}
			
			xp += amount;
			while (xp >= xpm) {
				level++;
				Registry.world.texts.add(new LevelUpText);
				xp -= xpm;
				xpm += 20;
				
				if (level >= 50) {
					level = 50;
					xp = 0;
				}
				
				if (level == 2) {
					Registry.engine.push(new TextState(Font.REDTEXT, "You've leveled up! Leveling up will increase the damage you deal with spells and lower the amount of time it takes to charge them."));
				}
			}
		}
		
		public static function soundEnabled():Boolean {
			return sound == 1;
		}
		
		public static function musicEnabled():Boolean {
			return music == 1;
		}
		
		public static function numJumps():int {
			return jumps[0] + jumps[1] + jumps[2] + jumps[3] + jumps[4]; 
		}
		
		public static function numSpeeds():int {
			return speeds[0] + speeds[1] + speeds[2] + speeds[3] + speeds[4]; 
		}
		
		public static function numHearts():int {
			return hearts[0] + hearts[1] + hearts[2] + hearts[3] + hearts[4]; 
		}
		
		public static const ON:uint = 1;
		public static const OFF:uint = 0;
	}
}
