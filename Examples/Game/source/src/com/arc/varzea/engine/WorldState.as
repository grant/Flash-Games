package com.arc.varzea.engine {
	import com.arc.flixel.ArcGroup;
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcRect;
	import com.arc.flixel.ArcSfxr;
	import com.arc.flixel.ArcSprite;
	import com.arc.flixel.DataSerializer;
	import com.arc.flixel.input.Input;
	import com.arc.flixel.message.MessageSystem;
	import com.arc.varzea.entity.Entity;
	import com.arc.varzea.entity.Player;
	import com.arc.varzea.entity.enemy.*;
	import com.arc.varzea.entity.object.Collectible;
	import com.arc.varzea.entity.object.DoubleJumpOrb;
	import com.arc.varzea.entity.object.HeartOrb;
	import com.arc.varzea.entity.object.JumpOrb;
	import com.arc.varzea.entity.object.Key;
	import com.arc.varzea.entity.object.SaveCrystal;
	import com.arc.varzea.entity.object.SpeedOrb;
	import com.arc.varzea.entity.object.SpellOrb;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.resource.Sound;
	import com.arc.varzea.ui.UI;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.util.SoundSystem;
	import com.arc.varzea.util.Util;
	import com.arc.varzea.world.SpawnMap;
	import com.arc.varzea.world.Tile;
	import com.arc.varzea.world.World;
	import com.arc.varzea.world.WorldBuilder;
	
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;

	public class WorldState extends GameState {
		public var builder:WorldBuilder;
		public var world:World;
		public var background:FlxTilemap;
		public var backgroundc:FlxTilemap;
		public var player:Player;
		public var projectiles:ArcGroup;
		public var particles:ArcGroup;
		
		public var entities:ArcGroup;
		public var texts:ArcGroup;
		
		public var objects:ArcGroup;
		public var save:SaveCrystal;
		public var heart:HeartOrb;
		
		//public static const SPAWN_WIDTH:uint = 
		public var spawnBounds:ArcRect = new ArcRect;
		public var spawnMap:SpawnMap = new SpawnMap;
		
		public var fader:ArcSprite;
		public var loaded:Boolean = false;
		
		public function WorldState() {
			persist = true;
			SoundSystem.music(Sound.song, 0.5);
			Registry.world = this;
			builder = new WorldBuilder().build(Resource.WORLD, Resource.WORLD_BACKGROUND, Resource.WORLD_BACKGROUNDC);
			
			backgroundc = new FlxTilemap;
			//trace(builder.background);
			backgroundc.loadMap(builder.backgroundc, Resource.TILES_BACKGROUNDC, Tile.WIDTH, Tile.HEIGHT, FlxTilemap.OFF, 0, 1, 100);
			this.add(backgroundc);
			
			background = new FlxTilemap;
			//trace(builder.background);
			background.loadMap(builder.background, Resource.TILES_BACKGROUND, Tile.WIDTH, Tile.HEIGHT, FlxTilemap.OFF, 0, 1, 100);
			this.add(background);
			
			entities = new ArcGroup;
			entities.add(objects = new ArcGroup);
			entities.add(player = new Player(0, 0));
			this.add(entities);
			
			this.add(projectiles = new ArcGroup);
			this.add(particles = new ArcGroup);
			particles.add(ArcParticleSystem.emitters);
			this.add(world = new World(builder.foreground));
			this.add(texts = new ArcGroup);
			
			this.add(new UI);
			
			FlxG.camera.follow(player);
			FlxG.worldBounds.width = FlxG.width + Tile.WIDTH * 30;
			FlxG.worldBounds.height = FlxG.height + Tile.HEIGHT * 30;	
			
			fader = new ArcSprite(0, 0);
			fader.scrollFactor = new FlxPoint(0, 0);
			fader.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
			this.add(fader);
			
			reset();
		}
		
		public function reset():void {
			projectiles.clear();
			objects.clear();
			texts.clear();
			spawnMap.reset();
			Registry.resetHP();
			
			if (loaded) {
				fader.alpha = 0;
			}
			
			if (SaveCrystal.current.x == 0) {
				player.x = Tile.WIDTH * 78;
				player.y = Tile.HEIGHT * 54 + 18;
			} else {
				player.x = Tile.WIDTH * SaveCrystal.current.x + 4;
				player.y = Tile.HEIGHT * SaveCrystal.current.y - 1;
			}
			
			FlxG.camera.focusOn(new FlxPoint(player.x, player.y));
			spawnBounds.x = spawnx;
			spawnBounds.y = spawny;
			spawnBounds.width = 27;
			spawnBounds.height = 19;
			spawnAll();
		}
		
		private static const GC_DELAY:Number = 20;
		private var gcTimer:Number = GC_DELAY;
		public function garbageCollect():void {
			gc(projectiles);
			gc(particles);
			gc(texts);
			gc(objects);
		}
		
		private function gc(group:ArcGroup):void {
			var oldMembers:Array = group.members;
			var newMembers:Array = [];
			for (var i:uint = 0; i < oldMembers.length; i++) {
				var object:FlxBasic = oldMembers[i] as FlxBasic;
				if (object != null && object.exists && object.alive) {
					newMembers.push(object);
				}
			}
			group.members = newMembers;
			oldMembers = null;
		}
		
		private function spawnAll():void {
			for (var x:uint = spawnBounds.x; x <= spawnBounds.x + spawnBounds.width; x++) {
				for (var y:uint = spawnBounds.y; y <= spawnBounds.y + spawnBounds.height; y++) {
					spawnPixel(x, y);
				}
			}
		}
		
		private function spawn():void {
			var sx:int = spawnx;
			var sy:int = spawny;
			
			var x:uint, y:uint;
			var spawned:uint = 0;
			
			if (sx < spawnBounds.x) {
				for (x = sx; x < spawnBounds.x; x++) {
					for (y = spawnBounds.y; y <= spawnBounds.y + spawnBounds.width; y++) {
						spawnPixel(x, y);
						spawned++;
					}
				}
			} else if (sx + spawnBounds.width > spawnBounds.x + spawnBounds.width) {
				for (x = spawnBounds.x + spawnBounds.width + 1; x <= sx + spawnBounds.width; x++) {
					for (y = spawnBounds.y; y <= spawnBounds.y + spawnBounds.width; y++) {
						spawnPixel(x, y);
						spawned++;
					}
				}
			}
			
			if (sy < spawnBounds.y) {
				for (x = spawnBounds.x; x <= spawnBounds.x + spawnBounds.width; x++) {
					for (y = sy; y < spawnBounds.y; y++) {
						spawnPixel(x, y);
						spawned++;
					}
				}
			} else if (sy + spawnBounds.height > spawnBounds.y + spawnBounds.height) {
				for (x = spawnBounds.x; x <= spawnBounds.x + spawnBounds.width; x++) {
					for (y = spawnBounds.y + spawnBounds.height + 1; y <= sy + spawnBounds.height; y++) {
						spawnPixel(x, y);
						spawned++;
					}
				}
			}
			
			spawnBounds.x = sx;
			spawnBounds.y = sy;
			
			if (spawned > 0) {
				//trace("SPAWNED", spawned);
			}
		}
		
		private function spawnPixel(x:uint, y:uint):void {
			var pixel:uint = builder.pixels.getPixel(x, y);
			if (pixel == 0xffffff) {
				return;
			}
			
			if (!spawnMap.isSpawned(x, y)) {
				spawnMap.spawn(x, y);
				
				if (pixel != Tile.GRASS && pixel != Tile.GRASS_BG && pixel != 0xffffff) {
					//trace(pixel);
				}
				
				var entity:Entity;
				switch (pixel) {
					// Orbs
					case 0xe2b700: entity = new SpellOrb(x, y, 0); break;
					case 0xe2b701: entity = new SpellOrb(x, y, 1); break;
					case 0xe2b702: entity = new SpellOrb(x, y, 2); break;
					case 0xe2b703: entity = new SpellOrb(x, y, 3); break;
					case 0xe2b704: entity = new SpellOrb(x, y, 4); break;
					case 0xe2b705: entity = new SpellOrb(x, y, 5); break;
					case 0x79a7c5: entity = new DoubleJumpOrb(x, y); break;
					
					case 0xff8400: entity = new JumpOrb(x, y, 0); break;
					case 0xff8401: entity = new JumpOrb(x, y, 1); break;
					case 0xff8402: entity = new JumpOrb(x, y, 2); break;
					case 0xff8403: entity = new JumpOrb(x, y, 3); break;
					case 0xff8404: entity = new JumpOrb(x, y, 4); break;
					
					case 0x4eff00: entity = new SpeedOrb(x, y, 0); break;
					case 0x4eff01: entity = new SpeedOrb(x, y, 1); break;
					case 0x4eff02: entity = new SpeedOrb(x, y, 2); break;
					case 0x4eff03: entity = new SpeedOrb(x, y, 3); break;
					case 0x4eff04: entity = new SpeedOrb(x, y, 4); break;
					
					case 0xba00ff: entity = new HeartOrb(x, y, 0); break;
					case 0xba01ff: entity = new HeartOrb(x, y, 1); break;
					case 0xba02ff: entity = new HeartOrb(x, y, 2); break;
					case 0xba03ff: entity = new HeartOrb(x, y, 3); break;
					case 0xba04ff: entity = new HeartOrb(x, y, 4); break;
					
					// Items
					case 0x00aeff: entity = new SaveCrystal(x, y); break;
					
					// Enemies
					case 0x5a0000: entity = new SmallSlime(x, y); break;
					case 0x421600: entity = new MediumSlime(x, y); break;
					case 0x5f3300: entity = new LargeSlime(x, y); break;
					case 0x855252: entity = new Butterfly(x, y); break;
					case 0x562bd1: entity = new Crystar(x, y); break;
					case 0xcd59ab: entity = new BounceSpike(x, y, FlxObject.RIGHT); break;
					case 0xb4378f: entity = new BounceSpike(x, y, FlxObject.DOWN); break;
					case 0xa0a0a0: entity = new Spike(x, y); break;
					case 0xff5858: entity = new Fire(x, y); break;
					case 0xce00d6: entity = Registry.miniboss == 0 ? new Miniboss(x, y) : null; break;
					case 0x686238: entity = new Lever(x, y); break;
					case 0x968a3b: entity = new SlidingDoor(x, y); break;
					case 0xf846ff: entity = new Wizress(x, y); break;
					case 0x121212: entity = new Kitty(x, y); break;
					
					case 0xcab500: entity = new Key(x, y, 0); break;
					case 0xcab501: entity = new Key(x, y, 1); break;
					case 0xcab502: entity = new Key(x, y, 2); break;
					case 0xcab503: entity = new Key(x, y, 3); break;
					case 0xcab504: entity = new Key(x, y, 4); break;
					case 0xcab505: entity = new Key(x, y, 5); break;
				}
				
				if (entity != null) {
					objects.add(entity);
				}
			}
		}
		
		private function get spawnx():uint { return Math.max(0, Util.p2c(FlxG.camera.scroll.x) - 2); }
		private function get spawny():uint { return Math.max(0, Util.p2c(FlxG.camera.scroll.y) - 2); }
		
		public function back():void {
			FlxG.camera.fade(0xff000000, 0.5, function():void {
				DataSerializer.save();
				Registry.engine.pop();
				(Registry.engine.current as TitleState).music();
				FlxG.camera.stopFX();
			});
		}
		
		override public function update():void {
			/*if (FlxG.keys.justPressed("X")) {
				DataSerializer.save();
			} else if (FlxG.keys.justPressed("C")) {
				DataSerializer.load();
			} else if (FlxG.keys.justPressed("T")) {
				trace(Registry.time);
			} else if (FlxG.keys.justPressed("R")) {
				DataSerializer.reset();
			}*/
			
			if (FlxG.keys.justPressed("T")) {
				trace(Registry.time);
			}
			
			if (Input.pressed("escape")) {
				back();
			}
			
			if (!loaded) {
				fader.alpha -= FlxG.elapsed * 2;
				player.invulnerable = 1;
				if (fader.alpha <= 0) {
					loaded = true;
					player.immobilized = 0.1;
				} else {
					player.immobilized = 0;
				}
			}
			
			gcTimer -= FlxG.elapsed;
			if (gcTimer <= 0) {
				gcTimer = GC_DELAY;
				garbageCollect();
			}
			
			FlxG.worldBounds.x = FlxG.camera.scroll.x - Tile.WIDTH * 15;
			FlxG.worldBounds.y = FlxG.camera.scroll.y - Tile.HEIGHT * 15;
			super.update();
			
			FlxG.overlap(player, objects, objectOverlap);
			FlxG.overlap(projectiles, objects, projectileObjectCallback);
			FlxG.collide(projectiles, world, projectileCallback);
			FlxG.collide(entities, world);
			
			spawn();
			Registry.time += FlxG.elapsed;
			
			/*
			if (Input.held("right")) {
				FlxG.camera.scroll.x += 4;
			} else if (Input.held("left")) {
				FlxG.camera.scroll.x -= 4;
			}
			
			if (Input.held("up")) {
				FlxG.camera.scroll.y -= 4;
			} else if (Input.held("down")) {
				FlxG.camera.scroll.y += 4;
			}
			*/
		}
		
		override public function draw():void {
			super.draw();
		}
		
		private function projectileCallback(a:FlxObject, b:FlxObject):void {
			ArcSfxr.play("thud");
			a.kill();
		}
		
		private function objectOverlap(a:FlxObject, b:FlxObject):void {
			var player:Player = a as Player;
			
			if (b is Collectible) {
				var collectible:Collectible = b as Collectible;
				collectible.collect();
			} else if (b is Enemy) {
				var enemy:Enemy = b as Enemy;
				//b.kill();
				player.knock(enemy);
			}
		}
		
		private function projectileObjectCallback(a:FlxObject, b:FlxObject):void {
			var spell:Spell = a as Spell;
			var entity:Entity = b as Entity;
			
			entity.hit(spell);
		}
	}
}
