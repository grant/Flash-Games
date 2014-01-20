package com.arc.varzea.world {
	import com.arc.flixel.ArcSprite;
	
	import flash.display.BitmapData;

	public class WorldBuilder {
		public var pixels:BitmapData;
		public var backgroundPixels:BitmapData
		public var backgroundcPixels:BitmapData
		
		private var fg:String;
		private var bg:String;
		private var bgc:String;
		
		public function WorldBuilder() {
			fg = "";
			bg = "";
			bgc = "";
		}
		
		public function build(foreground:Class, background:Class, backgroundc:Class):WorldBuilder {
			var row:Vector.<uint> = new Vector.<uint>;
			var col:Vector.<String> = new Vector.<String>;
			var bgrow:Vector.<uint> = new Vector.<uint>;
			var bgcol:Vector.<String> = new Vector.<String>;
			var bgcrow:Vector.<uint> = new Vector.<uint>;
			var bgccol:Vector.<String> = new Vector.<String>;
			
			pixels = new ArcSprite(0, 0, foreground).pixels;
			backgroundPixels = new ArcSprite(0, 0, background).pixels;
			backgroundcPixels = new ArcSprite(0, 0, backgroundc).pixels;
			
			for (var y:uint = 0; y < pixels.height; y++) {
				row.length = 0;
				bgrow.length = 0;
				bgcrow.length = 0;
				for (var x:uint = 0; x < pixels.width; x++) {
					var pixel:PixelSet = new PixelSet(pixels, backgroundPixels, backgroundcPixels, x, y);
					row.push(pixel.tile());
					bgrow.push(pixel.background());
					bgcrow.push(pixel.backgroundc());
				}
				col.push(row.join(","));
				bgcol.push(bgrow.join(","));
				bgccol.push(bgcrow.join(","));
			}
			
			fg = col.join("\n");
			bg = bgcol.join("\n");
			bgc = bgccol.join("\n");
			
			return this;
		}
		
		public function get foreground():String {
			return fg;
		}
		
		public function get background():String {
			return bg;
		}
		
		public function get backgroundc():String {
			return bgc;
		}
	}
}
