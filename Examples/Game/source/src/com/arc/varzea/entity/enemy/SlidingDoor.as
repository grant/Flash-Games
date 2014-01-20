package com.arc.varzea.entity.enemy {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcU;
	import com.arc.varzea.entity.projectile.Douse;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxG;
	
	public class SlidingDoor extends Enemy {
		private var sx:uint, sy:uint;
		private var sliding:Boolean;
		
		public function SlidingDoor(x:uint, y:uint) {
			super(x, y);
			loadGraphic(Resource.SLIDING_DOOR, false, false);
			killable = false;
			
			this.sx = this.x;
			this.sy = this.y;
			
			immovable = true;
			harmful = false;
		}
		
		override public function update():void {
			if (sliding) {
				y += FlxG.elapsed * 100;
			}
			
			if (y > sy + height) {
				kill();
			}
			
			super.update();
		}
		
		override public function deathEmit():void {
			
		}
		
		public function slide():void {
			sliding = true;
		}
	}
}
