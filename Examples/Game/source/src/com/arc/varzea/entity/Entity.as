package com.arc.varzea.entity {
	import com.arc.flixel.ArcRect;
	import com.arc.flixel.ArcSprite;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxG;

	public class Entity extends ArcSprite {
		protected var spawnX:uint, spawnY:uint;
		public var hp:int = 100;
		
		public function Entity(x:Number, y:Number, g:Class = null) {
			this.spawnX = x;
			this.spawnY = y;
			super(x * Tile.WIDTH, y * Tile.HEIGHT, g);
		}
		
		public function onscreen():Boolean {
			var bounds:ArcRect = Registry.world.spawnBounds;
			return x >= (bounds.x - 10) * Tile.WIDTH && x <= (bounds.x + bounds.width + 20) * Tile.WIDTH && y >= (bounds.y - 10) * Tile.HEIGHT && y <= (bounds.y + bounds.height + 20) * Tile.HEIGHT;
		}
		
		public function hit(spell:Spell):void {
			
		}
		
		override public function update():void {
			if (!onscreen()) {
				Registry.world.spawnMap.despawn(spawnX, spawnY);
				kill();
			}
			
			super.update();
		}
	}
}