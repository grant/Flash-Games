package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	public class Wizress extends Enemy {
		private var currentPhase:int = -1;
		private static const HP_MAX:uint = 1000;
		private var engaged:Boolean = false;
		private static var shownText:Boolean = false;
		
		public function Wizress(x:uint, y:uint) {
			super(x, y);
			this.y += 2;
			loadGraphic(Resource.WIZRESS_GREEN, true, true, 16, 32);
			initialize();
		}
		
		protected function initialize():void {
			addAnimation("walk", [0, 1, 2, 3], 8, true);
			addAnimation("stand", [0]);
			addAnimation("jump", [4]);
			addAnimation("fall", [5]);
			play("stand");
			
			hp = HP_MAX;
			walkSpeed = 50;
			
			acceleration.y = 400;
			
			width = 7;
			offset.x = 5;
			height = 14;
			offset.y = 18;
			
			facing = LEFT;
		}
		
		private function getPhase():uint {
			var ratio:Number = hp / HP_MAX;
			if (ratio > 0.75) {
				return 0;
			} else if (ratio > 0.5) {
				return 1;
			} else if (ratio > 0.25) {
				return 2;
			} else {
				return 3;
			}
		}
		
		private static const text:String = "I see you've found my lair. I suppose it was inevitable with your abilities and all.\n" +
			"I brought you to Arzea to study your powers. This world is laced with magic in everything that exists, and yet I was born without the abilities you currently possess.\n" +
			"Alas, it was a waste. The ways of your mysticism still elude me.\n" +
			"But no matter! I shall dispose of you and try again!";
		override public function update():void {
			if (!engaged) {
				if (ArcU.abs(y - Registry.world.player.y) < 3 && ArcU.abs(x - Registry.world.player.x) < 13 * Tile.WIDTH && Registry.world.player.isTouching(DOWN)) {
					engaged = true;
					
					if (!shownText) {
						Registry.engine.push(new TextState(Font.GRAY, text));
						shownText = true;
					}
				} else {
					return;
				}
			}
			
			var phase:int = getPhase();
			if (phase > currentPhase) {
				currentPhase = phase;
				
				var resource:Class;
				switch (currentPhase) {
					case 0: resource = Resource.WIZRESS_GREEN; tfirst(); break;
					case 1: resource = Resource.WIZRESS_YELLOW; tsecond(); break;
					case 2: resource = Resource.WIZRESS_ORANGE; tthird(); break;
					case 3: resource = Resource.WIZRESS_RED; tfinal(); break;
				}
				
				loadGraphic(resource, true, true, 16, 32);
				
				acceleration.y = 600;
				
				width = 7;
				offset.x = 5;
				height = 14;
				offset.y = 18;
				
				go(facing);
			}
			
			if (isTouching(DOWN)) {
				if (velocity.x != 0) {
					play("walk")
				}
			} else {
				if (velocity.y < 0) {
					play("jump");
				} else {
					play("fall");
				}
			}
			
			switch(currentPhase) {
				case 0: first(); break;
				case 1: second(); break;
				case 2: third(); break;
				case 3: final(); break;
			}
			
			if (shooting > 0) {
				shooting -= FlxG.elapsed;
				if (isTouching(DOWN)) {
					velocity.x = 0;
				}
			} else {
				if (velocity.x == 0) {
					trace(velocity.x);
					go(facing == LEFT ? RIGHT : LEFT);
				}
			}
			
			shootTimer -= FlxG.elapsed;
			if (shootTimer <= 0) {
				shootTimer = shootSpeed;
				shoot();
			}
			
			jumpTimer -= FlxG.elapsed;
			if (jumpTimer <= 0) {
				jumpTimer = ArcU.rand(jumpSpeed * 50, jumpSpeed * 100) / 100;
				velocity.y = -ArcU.rand(100, 300);
			}
			
			switchTimer -= FlxG.elapsed;
			if (switchTimer <= 0) {
				switchTimer = ArcU.rand(20, switchSpeed * 10) / 10;
				go(facing == LEFT ? RIGHT : LEFT);
			}
			
			super.update();
		}
		
		private function shoot():void {
			var midpoint:FlxPoint = getMidpoint();
			var tx:Number = (midpoint.x) / Tile.WIDTH;
			var ty:Number = (midpoint.y) / Tile.HEIGHT;
			
			Registry.world.objects.add(new Bullet(tx, ty, Math.atan2(Registry.world.player.midpoint.y - midpoint.y, Registry.world.player.midpoint.x - midpoint.x), 80));
			
			shooting = 0.2;
			facing = facing == LEFT ? RIGHT : LEFT;
		}
		
		private var shootSpeed:Number = 2;
		private var shootTimer:Number = 2;
		private var shooting:Number = 0;
		
		private var jumpSpeed:Number = 4;
		private var jumpTimer:Number = 4;
		
		private var switchSpeed:Number = 4;
		private var switchTimer:Number = ArcU.rand(1, 4);
		
		private var enemy:Enemy;
		
		private function first():void {
			
		}
		
		private function second():void {
			
		}
		
		private function third():void {
			
		}
		
		private function final():void {
			
		}
		
		// Transitions
		
		private function tfirst():void {
			walkSpeed = 50;
			
			enemy = new Crystar(55, 96);
			enemy.hp = 100;
			Registry.world.objects.add(enemy);
			
			enemy = new Crystar(70, 96);
			enemy.hp = 100;
			Registry.world.objects.add(enemy);
		}
		
		private function tsecond():void {
			walkSpeed = 70;
			
			enemy = new Crystar(56, 96);
			enemy.hp = 100;
			Registry.world.objects.add(enemy);
			
			enemy = new Crystar(69, 96);
			enemy.hp = 100;
			Registry.world.objects.add(enemy);
		}
		
		private function tthird():void {
			enemy = new Crystar(57, 96);
			enemy.hp = 100;
			Registry.world.objects.add(enemy);
			
			enemy = new Crystar(68, 96);
			enemy.hp = 100;
			Registry.world.objects.add(enemy);
			
			walkSpeed = 90;
		}
		
		private function tfinal():void {
			enemy = new Crystar(58, 96);
			enemy.hp = 100;
			Registry.world.objects.add(enemy);
			
			enemy = new Crystar(67, 96);
			enemy.hp = 100;
			Registry.world.objects.add(enemy);
			
			walkSpeed = 110;
		}
		
		override public function kill():void {
			velocity.x = 0;
			play("stand");
			
			Registry.engine.push(new TextState(Font.GRAY, "Aha... Perhaps you are deserving of your powers after all. But you are not worth the trouble. I will send you to the forsaken world I pulled you from.\nBut you've sown your touch in this magic place, and henceforth Arzea will yearn for your power. Good luck resisting it...! Ahaha!"));
			Registry.world.player.teleport = true;
			super.kill();
		}
	}
}
