package com.arc.varzea.world {
	public class Tile {
		public static const WIDTH:uint = 16;
		public static const HEIGHT:uint = 16;
		
		// offset into tilemap
		public static const GRASS:uint = 0x079e00;
		public static const SEA:uint = 0x265830;
		public static const FIRE:uint = 0x46393a;
		public static const LIGHT:uint = 0x6e5f00;
		
		public static const GRASS_BG:uint = 0x045000;
		public static const SEA_BG:uint = 0x123c1b;
		public static const FIRE_BG:uint = 0x2f1416;
		public static const LIGHT_BG:uint = 0x4c4200;
		
		public static const WATER:uint = 0x00c0ff;
		public static const LAVA:uint = 0xff0000;
		
		public static const OFFSETS:Object = {
			0x079e00: 0, // GRASS
			0x045000: 0, // GRASS
			0x265830: 5, // SEA
			0x123c1b: 5, // SEA
			0x46393a: 10, // FIRE
			0x2f1416: 10, // FIRE
			0x6e5f00: 15, // LIGHT
			0x4c4200: 15, // LIGHT
			0x2c2500: 15, // LIGHT
			
			0x00c0ff: 0, // WATER
			0xff0000: 3 // LAVA
		};
	}
}
