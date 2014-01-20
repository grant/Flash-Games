package com.arc.varzea.world {
	import com.arc.flixel.ArcU;
	import com.arc.varzea.util.Registry;
	
	import flash.display.BitmapData;

	public class PixelSet {
		public var c:int;
		public var l:int;
		public var r:int;
		public var u:int;
		public var d:int;
		public var ul:int;
		public var ur:int;
		public var dl:int;
		public var dr:int;
		public var b:int;
		public var sl:Boolean, sr:Boolean, su:Boolean, sd:Boolean, sul:Boolean, sur:Boolean, sdl:Boolean, sdr:Boolean;
		public var bc:Boolean, bb:Boolean, bsl:Boolean, bsr:Boolean, bsu:Boolean, bsd:Boolean, bsul:Boolean, bsur:Boolean, bsdl:Boolean, bsdr:Boolean;
		public var cc:int;
		
		public function PixelSet(pixels:BitmapData, backgroundPixels:BitmapData, backgroundcPixels:BitmapData, x:uint, y:uint) {
			if (x == 0) {
				l = ul = dl = -1;
			} else if (x == pixels.width - 1) {
				r = ur = dr = -1;
			}
			
			if (y == 0) {
				u = ul = ur = -1;
			} else if (y == pixels.height - 1) {
				d = dl = dr = -1;
			}
			
			c = pixels.getPixel(x, y);
			if (l != -1) { l = pixels.getPixel(x - 1, y); }
			if (r != -1) { r = pixels.getPixel(x + 1, y); }
			if (u != -1) { u = pixels.getPixel(x, y - 1); }
			if (d != -1) { d = pixels.getPixel(x, y + 1); }
			if (ul != -1) { ul = pixels.getPixel(x - 1, y - 1); }
			if (ur != -1) { ur = pixels.getPixel(x + 1, y - 1); }
			if (dl != -1) { dl = pixels.getPixel(x - 1, y + 1); }
			if (dr != -1) { dr = pixels.getPixel(x + 1, y + 1); }
			
			sl = l == -1 || c == l || isSolidTerrain(l);
			sr = r == -1 || c == r || isSolidTerrain(r);
			su = u == -1 || c == u || isSolidTerrain(u);
			sd = d == -1 || c == d || isSolidTerrain(d);
			sul = ul == -1 || c == ul || isSolidTerrain(ul);
			sur = ur == -1 || c == ur || isSolidTerrain(ur);
			sdl = dl == -1 || c == dl || isSolidTerrain(dl);
			sdr = dr == -1 || c == dr || isSolidTerrain(dr);
			
			b = backgroundPixels.getPixel(x, y);
			bb = isTerrain(b);
			bc = isTerrain(c) || isLiquid(c);
			bsl = isTerrain(l) || isLiquid(l) || isTerrain(backgroundPixels.getPixel(x - 1, y));
			bsr = isTerrain(r) || isLiquid(r) || isTerrain(backgroundPixels.getPixel(x + 1, y));
			bsu = isTerrain(u) || isLiquid(u) || isTerrain(backgroundPixels.getPixel(x, y - 1));
			bsd = isTerrain(d) || isLiquid(d) || isTerrain(backgroundPixels.getPixel(x, y + 1));
			bsul = isTerrain(ul) || isTerrain(backgroundPixels.getPixel(x - 1, y - 1));
			bsur = isTerrain(ur) || isTerrain(backgroundPixels.getPixel(x + 1, y - 1));
			bsdl = isTerrain(dl) || isTerrain(backgroundPixels.getPixel(x - 1, y + 1));
			bsdr = isTerrain(dr) || isTerrain(backgroundPixels.getPixel(x + 1, y + 1));
			
			cc = backgroundcPixels.getPixel(x, y);
		}
		
		private function isTerrain(pixel:uint):Boolean {
			return (isSolidTerrain(pixel) || pixel == Tile.GRASS_BG || pixel == Tile.SEA_BG || pixel == Tile.FIRE_BG || pixel == Tile.LIGHT_BG);
		}
		
		private function isSolidTerrain(pixel:uint):Boolean {
			return (pixel == Tile.GRASS || pixel == Tile.SEA || pixel == Tile.FIRE || pixel == Tile.LIGHT);
		}
		
		private function isLiquid(pixel:uint):Boolean {
			return pixel == Tile.WATER || pixel == Tile.LAVA;
		}
		
		public function tile():uint {
			if (c == 0x5f4b24) {
				return 187; // crumble
			}
			
			if (c == Tile.GRASS || c == Tile.SEA || c == Tile.FIRE || c == Tile.LIGHT) {
				return terrain() + Tile.OFFSETS[c];
			}
			
			if (isLiquid(c)) {
				return liquid() + Tile.OFFSETS[c];
			}
			
			// Locked doors
			switch(c) {
				case 0xd52a2a: return Registry.keys[0] == 1 ? 0 : 180; break;
				case 0xe0e563: return Registry.keys[1] == 1 ? 0 : 181; break;
				case 0x6ad52a: return Registry.keys[2] == 1 ? 0 : 182; break;
				case 0x6991c4: return Registry.keys[3] == 1 ? 0 : 183; break;
				case 0x9463e5: return Registry.keys[4] == 1 ? 0 : 184; break;
				case 0x8bedff: return Registry.keys[5] == 1 ? 0 : 185; break;
			}
			
			if (c != 0xffffff) {
				//return 121;
			}
			return 0;
		}
		
		private function liquid():uint {
			if (!su && bsl && !isLiquid(l)) {
				return 20;
			} else if (!su && bsr && !isLiquid(r)) {
				return 22;
			} else if (isLiquid(u)) {
				return 40;
			}
			return 21;
		}
		
		private function terrain():uint {
			if (sl && sr && su && sd) {
				return 121;
			} else if (sl && sr && sd && sul) {
				return 104;
			} else if (sl && sr && sd && sur) {
				return 103;
			} else if (sl && sr && sd) {
				return 101;
			} else if (su && sr && sd) {
				if (ul == Tile.WATER) {
					return 143;
				} else if (ul == Tile.LAVA) {
					return 160;
				}
				return 120;
			} else if (su && sl && sd) {
				if (ur == Tile.WATER) {
					return 144;
				} else if (ur == Tile.LAVA) {
					return 124;
				}
				return 122;
			} else if (sl && su && sr) {
				return 141;
			} else if (sr && sd) {
				if (ul == Tile.WATER) {
					return 163;
				} else if (ul == Tile.LAVA) {
					return 161;
				}
				return 100;
			} else if (sl && sd) {
				if (ur == Tile.WATER) {
					return 164;
				} else if (ur == Tile.LAVA) {
					return 162;
				}
				return 102;
			} else if (su && sr) {
				return 140;
			} else if (su && sl) {
				return 142;
			} else if (!sl && !sr && !su && !sd) {
				return 123;
			}
			
			return 0;
		}
		
		public function background():uint {
			var offset:uint = 0;
			if (Tile.OFFSETS[b] != null) {
				offset = Tile.OFFSETS[b];
			} else if (Tile.OFFSETS[l] != null) {
				offset = Tile.OFFSETS[l];
			} else if (Tile.OFFSETS[r] != null) {
				offset = Tile.OFFSETS[r];
			} else if (Tile.OFFSETS[u] != null) {
				offset = Tile.OFFSETS[u];
			} else if (Tile.OFFSETS[d] != null) {
				offset = Tile.OFFSETS[d];
			}
			return backgroundTerrain() + offset;
		}
		
		public function backgroundTerrain():uint {
			if (!bb && !bc) {
				return 0;
			}
			
			if (bsl && bsr && bsu && bsd) {
				return 121;
			} else if (bsl && bsr && bsd) {
				return 101;
			} else if (bsu && bsr && bsd) {
				return 120;
			} else if (bsu && bsl && bsd) {
				return 122;
			} else if (bsl && bsu && bsr) {
				return 141;
			} else if (bsr && bsd) {
				return 100;
			} else if (bsl && bsd) {
				return 102;
			} else if (bsu && bsr) {
				return 140;
			} else if (bsu && bsl) {
				return 142;
			}
			
			return 0;
		}
		
		public function backgroundc():uint {
			switch (cc) {
				case 0x022c00: return 121; break;
				case 0x05220b: return 121 + 5; break;
				case 0x1c0305: return 121 + 10; break;
				case 0x2c2500: return 121 + 15; break;
			}
			if (cc == 0x022c00) {
				return 121;
			}
			
			return ArcU.rand(20, 23);
		}
	}
}
