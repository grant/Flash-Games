package com.arc.flixel {
	import com.arc.flixel.ArcU;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	
	public class ArcSprite extends FlxSprite {
		protected var _colorRed:Number = 1.0;
		protected var _colorGreen:Number = 1.0;
		protected var _colorBlue:Number = 1.0;
		
		protected var _deathTimer:Number = 0;
		
		public var graphic:Class;
		
		public function ArcSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null) {
			super(X, Y, SimpleGraphic);
		}
		
		override public function loadGraphic(Graphic:Class, Animated:Boolean = false, Reverse:Boolean = false, Width:uint = 0, Height:uint = 0, Unique:Boolean = false):FlxSprite {
			this.graphic = Graphic;
			return super.loadGraphic(Graphic, Animated, Reverse, Width, Height, Unique);
		}
		
		public function hover():Boolean {
			return new ArcRect(x, y, width, height).hover();
		}
		
		public function offScreen():Boolean {
			var coords:FlxPoint = getScreenXY();
			return coords.x < -width || coords.x > FlxG.width || coords.y < -height || coords.y > FlxG.height;
		}
		
		public function get sourceRect():Rectangle {
			return _flashRect;
		}
		
		public function set sourceRect(R:Rectangle):void {
			_flashRect = R;
		}
		
		public function mark(T:Number):void {
			_deathTimer = T;
		}
		
		override public function update():void {
			if (_deathTimer > 0) {
				_deathTimer -= FlxG.elapsed;
				if (_deathTimer <= 0) {
					kill();
				}
			}
			
			if (flashTimer > 0) {
				color = flashColor;
				flashTimer -= FlxG.elapsed;
			} else {
				color = 0xffffff;
			}
			
			super.update();
		}
		
		public function get animation():String {
			return _curAnim == null ? null : _curAnim.name;
		}
		
		private static const FLASH_COLOR:Number = 0xffffff;
		private static const FLASH_TIME:Number = 0.1;
		private var flashTimer:Number = 0;
		private var flashColor:uint = 0xffffff;
		public function flash(color:uint = FLASH_COLOR, time:Number = FLASH_TIME):ArcSprite {
			flashTimer = time;
			flashColor = color;
			return this;
		}
		
		/*public function transform(Red:Number=1.0, Green:Number=1.0, Blue:Number=1.0, Alpha:Number=-1):void {
			_colorRed = Red;
			_colorGreen = Green;
			_colorBlue = Blue;
			
			if (Alpha != -1) {
				Alpha = ArcU.clamp(Alpha, 0, 1);
				if(Alpha != _alpha) {
					_alpha = Alpha;
				}
			}
			
			doTransform();
		}
		
		override public function set alpha(Alpha:Number):void {
			Alpha = ArcU.clamp(Alpha, 0, 1);
			if(Alpha == _alpha) return;
			_alpha = Alpha;
			doTransform();
		}
		
		protected function doTransform():void {
			if (_alpha != 1 || _colorRed != 1 || _colorBlue != 1 || _colorGreen != 1) {
				if (_ct == null) {
					_ct = new ColorTransform(_colorRed, _colorGreen, _colorBlue, _alpha);
				} else {
					_ct.redMultiplier = _colorRed;
					_ct.greenMultiplier = _colorGreen;
					_ct.blueMultiplier = _colorBlue;
					_ct.alphaMultiplier = _alpha;
				}
			} else {
				_ct = null;
			}
			calcFrame();
		}*/
	}
}
