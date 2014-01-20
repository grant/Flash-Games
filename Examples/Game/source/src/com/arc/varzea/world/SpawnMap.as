package com.arc.varzea.world {
	public class SpawnMap {
		private var map:Object = new Object;
		
		public function SpawnMap() {
		}
		
		public function spawn(x:uint, y:uint):void {
			map[x + "_" + y] = true;
		}
		
		public function isSpawned(x:uint, y:uint):Boolean {
			return map[x + "_" + y] == true;
		}
		
		public function despawn(x:uint, y:uint):void {
			delete map[x + "_" + y];
		}
		
		public function reset():void {
			map = new Object;
		}
	}
}
