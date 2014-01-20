package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.world.Tile;
	
	public class MediumSlime extends Slime {
		public function MediumSlime(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.MEDIUM_SLIME, true, true, 12, 9);
			this.y += Tile.HEIGHT - height;
			
			walkSpeed = 35;
			acceleration.y = 300;
			
			hp = 25;
			
			initialize();
		}
	}
}
