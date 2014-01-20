package com.arc.varzea.entity.object {
	import com.arc.flixel.ArcSprite;
	import com.arc.varzea.entity.Entity;

	public class Collectible extends Entity {
		public var collected:Boolean = false;
		
		public function Collectible(x:uint, y:uint, g:Class = null) {
			super(x, y, g);
		}
		
		public function collect():void {
			
		}
	}
}
