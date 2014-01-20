package com.arc.flixel.message {
	import com.arc.flixel.ArcSprite;
	import com.arc.flixel.input.Input;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	
	import org.flixel.FlxBitmapText;
	import org.flixel.FlxG;
	import org.flixel.FlxRect;

	public class MessageBox {
		private static const CORNER_SIZE:uint = 16;
		private static const GROW_RATE:Number = 4;
		private static const MESSAGE_SPEED:Number = 0.03;
		
		private var ul:ArcSprite, ur:ArcSprite, dl:ArcSprite, dr:ArcSprite;
		private var u:ArcSprite, r:ArcSprite, d:ArcSprite, l:ArcSprite;
		private var background:ArcSprite;
		private var target:FlxRect;
		private var scale:Number;
		
		private var messages:Vector.<Message>;
		private var message:Message;
		private var text:FlxBitmapText;
		
		private var timer:Number = 0;
		private var confirmHeld:Boolean = false;
		
		public static const INTRO:uint = 0;
		public static const SHOWING:uint = 1;
		public static const OUTRO:uint = 2;
		public static const HIDDEN:uint = 3;
		public var state:uint = HIDDEN;
		
		public function MessageBox() {
			ul = piece(0);
			ur = piece(2);
			dl = piece(6);
			dr = piece(8);
			
			u = piece(1);
			l = piece(3);
			r = piece(5);
			d = piece(7);
			
			background = new ArcSprite;
			background.makeGraphic(16, 16, 0xbb000000);
			background.scrollFactor.x = background.scrollFactor.y = 0;
			background.origin.x = background.origin.y = 0;

			target = new FlxRect(100, 100, 180, 44);
			scale = 0;
			
			messages = new Vector.<Message>;
		}
		
		public function push(msg:Message):void {
			messages.push(msg);
		}
		
		public function get active():Boolean {
			return state != HIDDEN || messages.length > 0;
		}
		
		public function update():void {
			switch(state) {
				case INTRO: intro(); break;
				case SHOWING: showing(); break;
				case OUTRO: outro(); break;
				case HIDDEN: hidden(); break;
			}
		}
		
		private function next():void {
			if (messages.length > 0) {
				message = messages.shift();
				text = new FlxBitmapText(target.x + 6, target.y + 6, TextState.globalFont, "", "left", message.position.width, true);
				text.scrollFactor.x = text.scrollFactor.y = 0;
			} else {
				state = OUTRO;
				text = null;
				message = null;
			}
		}
		
		/**
		 * STATES
		 */
		
		private function intro():void {
			scale += FlxG.elapsed * GROW_RATE;
			if (scale >= 1) {
				scale = 1;
				state = SHOWING;
			}
			
			calculateFrame();
		}
		
		private function showing():void {
			if (message == null) {
				if (messages.length == 0) {
					state = OUTRO;
					message = null;
					text = null;
					return;
				} else {
					next();
				}
			} else {
				tick();
			}
		}
		
		private function outro():void {
			scale -= FlxG.elapsed * GROW_RATE;
			if (scale <= 0) {
				scale = 0;
				state = HIDDEN;
			}
			
			calculateFrame();
		}
		
		private function hidden():void {
			if (messages.length > 0) {
				state = INTRO;
			}
		}
		
		/**
		 * CURRENT MESSAGE
		 */
		private function tick():void {
			if (text.text.length < message.message.length) {
				timer -= FlxG.elapsed;
				while (timer <= 0) {
					timer += ((Input.held("confirm") || FlxG.mouse.pressed()) && !confirmHeld) ? MESSAGE_SPEED * 0.1 : MESSAGE_SPEED;
					text.text = message.message.substr(0, text.text.length + 1);
				}
				
				if (!Input.held("confirm") && !FlxG.mouse.pressed()) {
					confirmHeld = false;
				}
			} else {
				if (Input.pressed("confirm") || FlxG.mouse.justPressed()) {
					confirmHeld = true;
					next();
				}
			}
		}
		
		/**
		 * DRAWING
		 */
		
		private function calculateFrame():void {
			var tw2:uint = target.width / 2;
			var th2:uint = target.height / 2;
			var w:uint = target.width * scale;
			var h:uint = target.height * scale;
			
			var scaleOffset:Number = ((1 - scale) * CORNER_SIZE);
			var left:uint = target.x + tw2 - (tw2 * scale) - scaleOffset;
			var top:uint = target.y + th2 - (th2 * scale) - scaleOffset;
			var right:uint = target.x + tw2 + (tw2 * scale) + scaleOffset;
			var bottom:uint = target.y + th2 + (th2 * scale) + scaleOffset;
			
			ul.x = left;
			ul.y = top;
			ur.x = right - CORNER_SIZE;
			ur.y = top;
			dl.x = left;
			dl.y = bottom - CORNER_SIZE;
			dr.x = right - CORNER_SIZE;
			dr.y = bottom - CORNER_SIZE;
			
			u.x = ul.x + CORNER_SIZE;
			u.y = ul.y;
			l.x = ul.x;
			l.y = ul.y + CORNER_SIZE;
			r.x = ur.x;
			r.y = ur.y + CORNER_SIZE;
			d.x = dl.x + CORNER_SIZE;
			d.y = dl.y;
			
			u.scale.x = ((target.width - CORNER_SIZE * 2) / CORNER_SIZE) * scale + 0.05;
			d.scale.x = u.scale.x;
			l.scale.y = ((target.height - CORNER_SIZE * 2) / CORNER_SIZE) * scale + 0.05;
			r.scale.y = l.scale.y;
			
			background.x = left + 8;
			background.y = top + 8;
			background.scale.x = ((target.width - CORNER_SIZE) / CORNER_SIZE) * scale + 0.05 + (1 - scale);
			background.scale.y = ((target.height - CORNER_SIZE) / CORNER_SIZE) * scale + 0.05 + (1 - scale);
		}
		
		public function draw():void {
			if (state == HIDDEN) {
				return;
			}
			
			background.draw();
			
			ul.draw();
			ur.draw();
			dl.draw();
			dr.draw();
			
			u.draw();
			l.draw();
			r.draw();
			d.draw();
			
			if (text != null) {
				text.draw();
			}
		}
		
		private function piece(frame:uint):ArcSprite {
			var corner:ArcSprite = new ArcSprite;
			corner.loadGraphic(TextState.globalFont == Font.REDTEXT ? Resource.MESSAGE_FRAME_RED : Resource.MESSAGE_FRAME, true, false, CORNER_SIZE, CORNER_SIZE);
			corner.frame = frame;
			corner.scrollFactor.x = corner.scrollFactor.y = 0;
			corner.origin.x = corner.origin.y = 0;
			return corner;
		}
	}
}