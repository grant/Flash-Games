package com.arc.flixel {
	import com.arc.flixel.ButtonState;
	import com.arc.varzea.util.Registry;
	
	import org.flixel.FlxG;
	
	public class ArcButton extends ArcSprite {
		private var _state:String = ButtonState.INACTIVE;
		private var _group:ArcButtonGroup;
		private var _selectable:Boolean = true;
		private var _callbackFunction:Function;
		private var _updateFunction:Function;
		
		public function ArcButton(X:Number, Y:Number, W:int, H:int, S:Class) {
			super(X, Y);
			loadGraphic(S, true, false, W, H);
			
			addAnimation("inactive", [0], 0, false);
			addAnimation("hover", [1], 0, false);
			addAnimation("selected", [2], 0, false);
		}
		
		override public function update():void {
			if (_state == ButtonState.SELECTED) {
				
			} else if (hover() && exists && alive && visible) {
				if (FlxG.mouse.justPressed()) {
					select(true, true);
					//scale.x = scale.y = 0.9;
					color = 0xdddddd;
				} else {
					if (_state != ButtonState.HOVER) {
						//SoundSystem.play(Sound.MENU_SELECT);
						ArcSfxr.play("blip");
					}
					if (FlxG.mouse.pressed()) {
						
					} else {
						//scale.x = scale.y = 1;
						color = 0xffffff;
					}
					_state = ButtonState.HOVER;
				}
			} else {
				_state = ButtonState.INACTIVE;
			}
			
			play(_state);
			if (_updateFunction != null) {
				_updateFunction();
			}
			
			super.update();
		}
		
		public function select(s:Boolean = true, c:Boolean = false):ArcButton {
			if (!s) {
				return this;
			}
			
			if (_group != null && _selectable) {
				_group.unselect();
			}
			
			if (_callbackFunction != null && c && visible) {
				trace(visible);
				ArcSfxr.play("pickup");
				_callbackFunction();
			}
			
			if(_selectable) {
				_state = ButtonState.SELECTED;
			} else {
				//_state = ButtonState.INACTIVE;
			}
			
			return this;
		}
		
		public function unselect():void {
			_state = ButtonState.INACTIVE;
		}
		
		public function setGroup(group:ArcButtonGroup, add:Boolean = false):ArcButton {
			this._group = group;
			if (add) {
				group.addButton(this);
			}
			return this;
		}
		
		public function selectable(S:Boolean):ArcButton {
			_selectable = S;
			return this;
		}
		
		public function callback(F:Function):ArcButton {
			_callbackFunction = F;
			return this;
		}
		
		public function setUpdate(F:Function):ArcButton {
			_updateFunction = F;
			return this;
		}
		
		public function get selected():Boolean {
			return _state == ButtonState.SELECTED;
		}
	}
}
