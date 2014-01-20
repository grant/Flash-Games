package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.world.Tile;

	public class SmallSlime extends Slime {
		public function SmallSlime(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.SMALL_SLIME, true, true, 10, 7);
			this.y += Tile.HEIGHT - height;
			
			walkSpeed = 40;
			acceleration.y = 300;
			
			hp = 10;
			
			initialize();
		}
	}
}
