package com.arc.varzea.entity {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.flixel.DataSerializer;
	import com.arc.flixel.input.Input;
	import com.arc.flixel.message.MessageSystem;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.entity.enemy.DamageText;
	import com.arc.varzea.entity.enemy.Enemy;
	import com.arc.varzea.entity.enemy.SlidingDoor;
	import com.arc.varzea.entity.object.SaveCrystal;
	import com.arc.varzea.entity.projectile.Caster;
	import com.arc.varzea.entity.projectile.Fireball;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.resource.Sound;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxBitmapText;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;

	public class Player extends Entity {
		private static const WALK_SPEED:Number = 80;
		private static const WATER_WALK_SPEED:Number = 40;
		private static const JUMP_SPEED:Number = 200;
		private static const WATER_JUMP_SPEED:Number = 130;
		private static const JUMP_TIME:Array = [0.03, 0.03, 0.03];
		
		private var jumps:Array = [0, 0, 0];
		private var jumping:Boolean = false;
		
		public var midpoint:FlxPoint = new FlxPoint;
		public var direction:Number;
		
		public var spell:uint = Spell.FIREBALL;
		public var chargeMeter:Number = 0;
		public var charge:ChargeCircle;
		
		public var knocked:Boolean = false;
		
		public static const INVULNERABLE_TIME:Number = 1;
		public var invulnerable:Number = 0;
		public var dying:Boolean;
		public var immobilized:Number = 0;
		
		public var water:Number = 0;
		
		private var i:int, j:int, k:int;
		private var sx:Number, sy:Number;
		
		public var teleport:Boolean = false;
		
		private var introText:Boolean = false;
		
		public function Player(x:uint, y:uint) {
			super(x, y);
			this.y += 18;
			sx = this.x;
			sy = this.y;
			
			loadGraphic(Resource.WIZARD, true, true, 16, 32);
			charge = new ChargeCircle(this);
			
			drag.x = 400;
			acceleration.y = 600;
			
			width = 7;
			offset.x = 5;
			height = 14;
			offset.y = 18;
			
			addAnimation("walk", [0, 1, 2, 3], 8, true);
			addAnimation("stand", [0]);
			addAnimation("jump", [4]);
			addAnimation("fall", [5]);
			play("stand");
		}
		
		override public function update():void {
			getMidpoint(midpoint);
			
			if (teleport) {
				velocity.x = 0;
				velocity.y = 0;
				immovable = true;
				solid = false;
				moves = false;
				
				if (alpha == 1) {
					ArcParticleSystem.emit(Registry.world.particles, "fireball", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
					ArcParticleSystem.emit(Registry.world.particles, "key", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
				}
				alpha -= FlxG.elapsed * 2;
				if (alpha <= 0) {
					Registry.world.fader.alpha += FlxG.elapsed / 2;
					if (Registry.world.fader.alpha >= 1) {
						endTimer += FlxG.elapsed;
						if (endTimer >= 1) {
							if (!endText) {
								Registry.engine.push(new TextState(Font.GRAY, "I... Am... Home!"));
								endText = true;
							} else {
								if (!MessageSystem.active) {
									/*die();
									endTimer = 0;
									endText = false;
									teleport = false;
									moves = true;
									solid = true;
									immovable = false;*/
									Registry.world.back();
								}
							}
						}
					}
				}
				return;
			}
			
			input();
			physics();
			
			if (dying) {
				alpha -= FlxG.elapsed;
				if (alpha <= 0) {
					die();
				}
			}
			
			super.update();
		}
		
		private var endTimer:Number = 0;
		private var endText:Boolean = false;
		
		override public function postUpdate():void {
			super.postUpdate();
			charge.update();
		}
		
		override public function draw():void {
			super.draw();
			charge.draw();
		}
		
		private function input():void {
			if (FlxG.keys.justPressed("Z")) {
				//kill();
				//return;
			}
			
			if (knocked) {
				if (velocity.y >= 0) {
					knocked = false;
				}
				return;
			}
			
			if (immobilized > 0) {
				immobilized -= FlxG.elapsed;
				return;
			}
			
			if (!introText && SaveCrystal.current.x == 0) {
				Registry.engine.push(new TextState(Font.REDTEXT, "Use A/D or Left/Right to move. You can use W, Space, or Up to jump."));
				Registry.engine.push(new TextState(Font.GRAY, "I've been in this cave for 3 days. The only life I've seen is the numerous aggressive monsters outside. I don't know how I got here, but I don't think anyone is coming for me. I think it's time to explore."));
				introText = true;
			}
			
			if (Input.held("right")) {
				velocity.x = inWater() ? WATER_WALK_SPEED : WALK_SPEED;
				velocity.x += Registry.numSpeeds() * 10;
			} else if (Input.held("left")) {
				velocity.x = inWater() ? -WATER_WALK_SPEED : -WALK_SPEED;
				velocity.x -= Registry.numSpeeds() * 10;
			} else {
				velocity.x = 0;
			}
			
			if (FlxG.mouse.x < x) {
				facing = LEFT;
			} else {
				facing = RIGHT;
			}
			
			getMidpoint(midpoint);
			direction = Math.atan2(FlxG.mouse.y - midpoint.y, FlxG.mouse.x - midpoint.x);
			
			inputCast();
			inputJump();
			showAnimation();
			
			/*if (FlxG.keys.justPressed("LEFT")) {
				x -= Tile.WIDTH * 10;
			} else if (FlxG.keys.justPressed("RIGHT")) {
				x += Tile.WIDTH * 10;
			} else if (FlxG.keys.justPressed("UP")) {
				y -= Tile.WIDTH * 10;
			} else if (FlxG.keys.justPressed("DOWN")) {
				y += Tile.WIDTH * 10;
			}
			
			if (FlxG.keys.justPressed("R")) {
				Registry.hearts = [1, 1, 1, 1, 1];
				Registry.jumps = [1, 1, 1, 1, 1];
				Registry.speeds = [1, 1, 1, 1, 1];
			}*/
			
			if ((FlxG.keys.justPressed("ONE") || FlxG.keys.justPressed("NUMPADONE")) && Registry.fireball) {
				spell = Spell.FIREBALL;
				ArcSfxr.play("blip");
			} else if ((FlxG.keys.justPressed("TWO") || FlxG.keys.justPressed("NUMPADTWO")) && Registry.douse) {
				spell = Spell.DOUSE;
				ArcSfxr.play("blip");
			} else if ((FlxG.keys.justPressed("THREE") || FlxG.keys.justPressed("NUMPADTHREE")) && Registry.chill) {
				spell = Spell.CHILL;
				ArcSfxr.play("blip");
			} else if ((FlxG.keys.justPressed("FOUR") || FlxG.keys.justPressed("NUMPADFOUR")) && Registry.gust) {
				spell = Spell.GUST;
				ArcSfxr.play("blip");
			} else if ((FlxG.keys.justPressed("FIVE") || FlxG.keys.justPressed("NUMPADFIVE")) && Registry.shock) {
				spell = Spell.SHOCK;
				ArcSfxr.play("blip");
			} else if ((FlxG.keys.justPressed("SIX") || FlxG.keys.justPressed("NUMPADSIX")) && Registry.spire) {
				spell = Spell.SPIRE;
				ArcSfxr.play("blip");
			}
		}
		
		private function showAnimation():void {
			if (!isTouching(DOWN)) {
				if (velocity.y < 0) {
					play("jump");
				} else {
					play("fall");
				}
			} else {
				if (velocity.x != 0) {
					play("walk");
				} else {
					play("stand");
				}
			}
		}
		
		private static const CAST_DELAY:Number = 0.2;
		private var castTimer:Number = 0;
		private function inputCast():void {
			castTimer -= FlxG.elapsed;
			
			if (FlxG.mouse.pressed() || Input.held("shoot")) {
				chargeMeter += FlxG.elapsed;
			} else if (chargeMeter > 0 && castTimer <= 0) {
				chargeMeter = 0;
				castTimer = CAST_DELAY;
				Caster.cast(this);
			}
		}
		
		private function inputJump():void {
			var jumpAbility:Array = [true, Registry.doublejump == 1, false];
			for (i = 0; i < jumps.length; i++) {
				if (!jumpAbility[i]) {
					break;
				}
				
				var jump:Number = jumps[i];
				if (jump <= 0) {
					continue;
				}
				
				if (Input.pressed("jump")) {
					jumping = true;
					if (i == 0) {
						ArcSfxr.play("jump");
					} else {
						ArcSfxr.play("doublejump");
					}
				}
				
				if (Input.held("jump") && jumping) {
					jumps[i] -= FlxG.elapsed;
					if (jumps[i] <= 0 || isTouching(UP)) {
						jumping = false;
					}
					velocity.y = inWater() ? -WATER_JUMP_SPEED : -JUMP_SPEED;
				} else if (jumping) {
					jumping = false;
					jumps[i] = 0;
				}
				
				break;
			}
			
			if (!isTouching(DOWN)) {
				if (!Input.held("jump")) {
					jumps[0] = 0;
				}
			} else {
				for (i = 0; i < jumps.length; i++) {
					jumps[i] = JUMP_TIME[i] + 0.03 * Registry.numJumps();
				}
			}
		}
		
		private function physics():void {			
			if (dying) {
				return;
			}
			
			if (invulnerable > 0) {
				color = 0xff0000;
				alpha = 0.7;
				invulnerable -= FlxG.elapsed;
			} else {
				color = 0xffffff;
				alpha = 1;
			}
			
			water -= FlxG.elapsed;
			if (inWater()) {
				acceleration.y = 100;
				if (velocity.y < 0) {
					maxVelocity.y = 400;
				} else {
					maxVelocity.y = 50; 
				}
			} else {
				drag.x = 400;
				maxVelocity.y = 400;
				acceleration.y = 600;
			}
		}
		
		public function isInvulnerable():Boolean {
			return invulnerable > 0;
		}
		
		public function knock(enemy:Enemy):void {
			if (enemy is SlidingDoor) {
				x = enemy.x - width;
			}
			
			if (!enemy.barrier && (isInvulnerable() || !enemy.harmful)) {
				return;
			}
			velocity.y = -100;
			velocity.x = enemy.x > x ? -150 : 150;
			y -= 2;
			knocked = true;
			invulnerable = INVULNERABLE_TIME;
			
			Registry.hp--;
			if (Registry.hp <= 0) {
				kill();
			} else {
				ArcSfxr.play("hitenemy");
			}
		}
		
		public function inWater():Boolean {
			return water > 0;
		}
		
		override public function kill():void {
			dying = true;
			solid = false;
			moves = false;
			frame = 0;
			FlxG.camera.shake(0.01, 0.3);
			ArcSfxr.play("playerdie");
		}
		
		private function die():void {			
			velocity.x = 0;
			velocity.y = 0;
			knocked = false;
			jumping = false;
			invulnerable = 2;
			solid = true;
			moves = true;
			dying = false;
			charge.charged = false;
			chargeMeter = 0;
			immobilized = 0.3;
			FlxG.camera.flash(0xffffffff, 1.0);
			Registry.world.reset();
			DataSerializer.save();
		}
	}
}
