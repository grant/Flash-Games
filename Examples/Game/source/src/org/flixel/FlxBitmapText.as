package org.flixel
{
	import adobe.utils.CustomActions;
	import org.flixel.* ;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	
	/**
	 * This is a text display class which uses bitmap fonts.
	 */
	public class FlxBitmapText extends FlxObject
	{
		/**
		 * The bitmap onto which the text is rendered
		 */
		protected var _pixels:BitmapData;
		/**
		 * The coordinates to which several things are copied
		 */
		protected var _p:Point;
		/**
		 * The bounding box of the internal bitmap
		 */
		protected var _frect:Rectangle;
		/**
		 * This is used to change the color of the bitmap
		 */
		protected var _cTransform:ColorTransform = new ColorTransform;
		/**
		 * The bitmap font to use
		 */
		protected var _font:FlxBitmapFont;
		/**
		 * The text to render
		 */
		protected var _text:String;
		/**
		 * The text alignment
		 */
		protected var _alignment:String;
		/**
		 * The default font to use
		 */
		static protected var _defaultFont:FlxBitmapFont;
		
		protected var _overrideWidth:int ;
		
		protected var _colorFont:Boolean ;
		
		protected var _lineWrap:Boolean ;
		
		protected var _splitLines:Array ;
		
		protected var _lineWidths:Array ;
		
		protected var _debugRender:Boolean = false ;
		
		public var truewidth:int;
		
		public function get lines():Array {
			return _splitLines;
		}
		
		/**
		 * Creates a new <code>FlxBitmapText</code> object.
		 *
		 * @param	X					The X position of the text
		 * @param	Y					The Y position of the text
		 * @param	Font				The bitmap font to use - NOTE: Passing null uses the default font
		 * @param	Text				The default text to display
		 * @param	Alignment			"Left", "Center", or "Right"
		 * @param	Width				The width of the text box in pixels (0 means auto)
		 */
		public function FlxBitmapText(X:int, Y:int, Font:FlxBitmapFont, Text:String=" ", Alignment:String="left", Width:Number=0, Color:Boolean = false)
		{
			if (Font == null) // Use the default font
				Font = _defaultFont ? _defaultFont : new FlxBitmapFont; // If it doesn't exist yet, create it
			_font = Font;
			_alignment = Alignment.toLowerCase();
			super();
			immovable = true;
			x = X;
			y = Y;
			width = Width;
			truewidth = Width;
			//_cTransform.color = 0;
			_cTransform.alphaMultiplier = 1.0 ;
			_lineWrap = true ;
			_p = new Point ;
			_colorFont = Color;
			text = Text ;
		}
		
		/**
		 * Updates the internal bitmap.
		 */
		public function calcFrame():void
		{
			var i:uint;
			var c:uint;
			
			if (_pixels)
				_pixels.dispose() ;
			_pixels = new BitmapData(width, height, true, 0x00000000); // Create a transparent bitmap
			var xOffset:uint;
			var yOffset:uint = 0;
			// Now we can start drawing on the bitmap
			for (i = 0; i < _splitLines.length; i++)
			{ // Loop through each line
				switch(_alignment)
				{ // Adjust where we start drawing for alignment
					case 'left':
						xOffset = 0;
					break;
					case 'center':
						xOffset = int((width - _lineWidths[i]) / 2);
					break;
					case 'right':
						xOffset = width - _lineWidths[i];
					break;
				}
				for (c = 0; c < _splitLines[i].length; c++)
				{ // Each character in the line
					if (_font.rects[_splitLines[i].charCodeAt(c)])
					{ // Make sure the character is in the font
						_p.x = xOffset + (overrideWidth ? Math.floor ((overrideWidth - _font.rects[_splitLines[i].charCodeAt(c)].width) / 2) : 0) ;
						_p.y = yOffset ;
						_pixels.copyPixels(_font.pixels, _font.rects[_splitLines[i].charCodeAt(c)], _p, null, null, true); // Copy it to the bitmap
						xOffset += (overrideWidth ? overrideWidth : _font.rects[_splitLines[i].charCodeAt(c)].width) + _font.horizontalPadding; // Add the width of the character
					}
				}
				yOffset += _font.height + _font.verticalPadding;
			}
			_frect = new Rectangle(0, 0, width, height); // The boundaries of the object
			//if (!_colorFont)
				_pixels.colorTransform(_frect, _cTransform); // Change the color if need be
		}
		
		protected function charWidth (char:uint):int
		{
			if (_font.rects[char] == null) return 0;
			return (overrideWidth ? overrideWidth :_font.rects[char].width) + _font.horizontalPadding ;
		}
		
		/**
		 * Splits the text into a series of LF delimited lines, using the word-wrap logic (if needed)
		 */
		public function splitLines(ourText:String, lineWidth:int):Array
		{
			ourText += " ";
			if (_lineWrap && width > 0)
			{
				var splitLines:Array = new Array ;
				
				var word:String = "" ;	// Current word string accumulator
				var wordw:int = 0 ;
				var line:String = "" ; // Current line string accumulator
				var linew:int = 0 ;
				
				// Now, wrap lines based on total width of FlxObject and individual character width
				// Changed to use a single-pass greedy-spacefill algorithm so no more possible lockups due to recursion
				for (var si:int = 0; si < ourText.length; si++)
				{
					var char:int = ourText.charCodeAt (si) ;
					if (char == 32)
					{
						// Trim whitespace
						word.replace (/^\s+|\s+$/g, "") ;
						if (word.length)
						{
							if (linew + wordw >= lineWidth)
							{
								splitLines.push (line) ;
								line = word ;
								linew = wordw ;
							} else
							{
								line += (line.length ? " " : "") + word ;
								linew += wordw + (line.length ? charWidth (32) : 0) ;
							}
						}
						word = "" ;
						wordw = 0 ;
					}
					else if (char == 10)
					{
						splitLines.push (line + " " + word) ;
						line = "" ;
						linew = 0 ;
						word = "" ;
						wordw = 0 ;
					}
					else
					{
						word += String.fromCharCode (char) ;
						wordw += charWidth (char) + _font.horizontalPadding ;
					}
				}
				
				if (word.length)
				{
					splitLines.push (line) ;
					line = word ;  // Finish word accum
				}
					
				if (line.length)
					splitLines.push (line) ;  // Finish line accum
					
			} else
			{
				// No word wrap, so just split lines by \n
				splitLines = _text.split("\n"); // An array of each line to render
			}
			
			return (splitLines) ;
		}
		
		/**
		 * Calculates the individual widths of each line that was parsed by splitLines()
		 */
		protected function calcLineWidths():void
		{
			// Reset height so that we can calculate the true height
			height = 0;
			
			_lineWidths = new Array(); // An array of the widths of each line
			// We need to get the size of the bitmap, so we'll examine the text character-by-character
			for (var i:int = 0; i < _splitLines.length; i++)
			{ // Loop through each line
				_lineWidths[i] = 0;
				for (var c:int = 0; c < _splitLines[i].length; c++)
				{ // Each character in the line
					if (_font.rects[_splitLines[i].charCodeAt(c)])
					{ // Does the character exist in the font?
						_lineWidths[i] += charWidth (_splitLines[i].charCodeAt(c)) ;
						//FlxG.log (_lines[i].charAt(c) + " w=" + _font.rects[_lines[i].charCodeAt(c)].width + " total=" + _lineWidths[i]) ;
					}
				}
				_lineWidths[i] -= _font.horizontalPadding ;
				if (_lineWidths[i] > width) // Find out which line is the widest
					width = _lineWidths[i]; // Use that line as the bitmap's width
				height += _font.height + _font.verticalPadding; // Set the height to the font height times the number of lines
			}
			height -= _font.verticalPadding; // Don't apply vertical padding to the last line
			if ((width < 1) || (height < 1))
			{ // If there's nothing to render
				width = 1; // Set the width
				height = 1; // And the height
			}
		}
		
		/**
		 * Draws the text to the screen.
		 */
		override public function draw():void
		{
			super.draw();
			getScreenXY(_point);
			
			if (_debugRender)
			{
				FlxG.camera.buffer.fillRect (new Rectangle (_point.x, _point.y, width, height), 0xFF00FF00) ;
				FlxG.camera.buffer.fillRect (new Rectangle (_point.x + 1, _point.y + 1, width - 2, height - 2), 0x0) ;
			}
			_p.x = _point.x ;
			_p.y = _point.y ;
			
			FlxG.camera.buffer.copyPixels(_pixels, _frect, _p, null, null, true);
		}
		
		/**
		 * Changes the text being displayed.
		 *
		 * @param	Text	The new string you want to display
		 */
		public function set text(Text:String):void
		{
			if (_text == Text) {
				return;
			}
			width = truewidth;
			_text = Text;
			
			// Split the text into lines based on word-wrap logic
			_splitLines = splitLines(_text, width) ;
			
			calcLineWidths() ;
			
			calcFrame(); // Update the bitmap
		}
		
		/**
		 * Getter to retrieve the text being displayed.
		 *
		 * @return	The text string being displayed.
		 */
		public function get text():String
		{
			return _text;
		}
		
		public function set overrideWidth(v:int):void
		{
			_overrideWidth = v ;
		}
		
		public function get overrideWidth():int
		{
			return _overrideWidth ;
		}
		
		public function set lineWrap(v:Boolean):void
		{
			_lineWrap = v ;
		}
		
		public function get lineWrap():Boolean
		{
			return _lineWrap ;
		}
		
		/**
		 * Sets the alignment of the text being displayed
		 *
		 * @param	A string indicating the desired alignment - acceptable values are "left", "right" and "center"
		 */
		public function set alignment(Alignment:String):void
		{
			_alignment = Alignment.toLowerCase(); // It's expecting the alignment to be all lowercase
			calcFrame(); // Update the bitmap
		}
		
		/**
		 * Gets the alignment of the text being displayed
		 *
		 * @return	A string indicating the current alignment.
		 */
		public function get alignment():String
		{
			return _alignment;
		}
		
		/**
		 * Sets the color of the text
		 *
		 * @param	Color	The color you want the text to appear (Note: it will become fully opaque!)
		 */
		public function set color(Color:uint):void
		{
			_cTransform.color = Color;
			calcFrame(); // Update the bitmap
		}
		
		public function get color():uint
		{
			return (_cTransform.color) ;
		}
		
		public function set debugRender(v:Boolean):void
		{
			_debugRender = v ;
		}
		
		public function set colorFont(v:Boolean):void
		{
			_colorFont = v ;
			calcFrame() ;
		}
		
		public function get colorFont():Boolean
		{
			return _colorFont ;
		}
		
		public function set alpha(Alpha:Number):void
		{
			if(Alpha > 1) Alpha = 1;
			if(Alpha < 0) Alpha = 0;
			if(Alpha == _cTransform.alphaMultiplier) return;
			_cTransform.alphaMultiplier = Alpha ;
			calcFrame();
		}
		
		public function get alpha():Number
		{
			return _cTransform.alphaMultiplier ;
		}
		
		/**
		 * Sets the font for the text
		 *
		 * @param	Font	The font to use
		 */
		public function set font(Font:FlxBitmapFont):void
		{
			if (Font == null) // Do we want to use the default font?
				Font = _defaultFont ? _defaultFont : new FlxBitmapFont; // If it doesn't exist yet, create it
			_font = Font;
			calcFrame();
		}
		
		/**
		 * Get the font used
		 *
		 * @return	FlxBitmapFont	The current font
		 */
		public function get font():FlxBitmapFont
		{
			return _font;
		}
		
		override public function destroy():void
		{
			super.destroy() ;
			_font = null ;
			_pixels.dispose() ;
		}
	}
}