package com.arc.varzea.entity.projectile {
	import com.arc.flixel.ArcRect;
	import com.arc.flixel.ArcSprite;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;

	public class Spell extends ArcSprite {
		public static const FIREBALL:uint = 0;
		public static const GUST:uint = 1;
		public static const CHILL:uint = 2;
		public static const SPIRE:uint = 3;
		public static const SHOCK:uint = 4;
		public static const DOUSE:uint = 5;
		
		public var charged:Boolean;
		public var contact:Boolean;
		
		public function Spell(x:uint, y:uint, g:Class = null) {
			super(x, y, g);
		}
		
		public function damage():uint {
			return 0;
		}
		
		public function onscreen():Boolean {
			var bounds:ArcRect = Registry.world.spawnBounds;
			return x >= (bounds.x - 10) * Tile.WIDTH && x <= (bounds.x + bounds.width + 20) * Tile.WIDTH && y >= (bounds.y - 10) * Tile.HEIGHT && y <= (bounds.y + bounds.height + 20) * Tile.HEIGHT;
		}
		
		override public function update():void {
			if (!onscreen()) {
				kill();
			}
		}
	}
}
