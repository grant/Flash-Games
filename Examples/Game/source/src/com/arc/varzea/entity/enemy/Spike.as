package com.arc.varzea.entity.enemy {
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxG;
	
	public class Spike extends Enemy {
		public function Spike(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.SPIKE, false, false, 16, 8);
			width = 12;
			offset.x = 2;
			height = 6;
			offset.y = 2;
			this.y += Tile.HEIGHT - height;
			killable = false;
		}
	}
}
