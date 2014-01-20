package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.world.Tile;
	
	public class LargeSlime extends Slime {
		public function LargeSlime(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.LARGE_SLIME, true, true, 16, 12);
			this.y += Tile.HEIGHT - height;
			
			walkSpeed = 30;
			acceleration.y = 300;
			
			hp = 50;
			
			initialize();
		}
	}
}
