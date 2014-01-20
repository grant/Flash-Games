package com.arc.varzea.entity.object {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	import com.arc.varzea.world.World;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.system.FlxTile;
	
	public class Key extends Collectible {
		private var index:uint;
		
		public function Key(x:uint, y:uint, index:uint) {
			super(x, y);
			loadGraphic(Resource.KEY, false, false, 16, 16);
			frame = index;
			this.index = index;
			
			if (Registry.keys[index] == 1) {
				kill();
			} else {
				trace("KEY: ", index, x, y, this.x, this.y);
			}
		}
		
		override public function update():void {
			super.update();
		}
		
		override public function collect():void {
			if (collected) {
				return;
			}
			
			var doorIndex:uint = 180 + index;
			var map:World = Registry.world.world;
			
			for each(var tileIndex:uint in map.getTileInstances(doorIndex)) {
				map.setTileByIndex(tileIndex, 0);
			}
			
			Registry.keys[index] = 1;
			ArcParticleSystem.emit(Registry.world.particles, "key", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
			FlxG.camera.flash(0xffffffff, 0.5);
			ArcSfxr.play("pickup");
			kill();
		}
	}
}
