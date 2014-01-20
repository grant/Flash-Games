package com.arc.varzea.entity.object {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.flixel.DataSerializer;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	import com.arc.varzea.world.Tile;
	
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;

	public class SaveCrystal extends Collectible {
		public static var current:FlxPoint = new FlxPoint;
		
		private var tx:uint = 0;
		private var ty:uint = 0;
		
		public function SaveCrystal(x:uint, y:uint) {
			tx = x;
			ty = y;
			super(x, y);
			this.y -= 16;
			
			if (current.x == tx && current.y == ty) {
				loadGraphic(Resource.SAVE_ACTIVE, true, false, 16, 32);
				collected = true;
			} else {
				loadGraphic(Resource.SAVE_INACTIVE, true, false, 16, 32);
			}
			
			addAnimation("float", [0, 0, 0, 1, 1, 2, 3, 3, 4, 4, 4, 3, 3, 2, 1, 1], 10, true);
			play("float");
		}
		
		override public function update():void {
			super.update();
			
			if (!collected) {
				return;
			} else {
				if (tx != current.x || ty != current.y) {
					collected = false;
					var cframe:uint = frame;
					loadGraphic(Resource.SAVE_INACTIVE, true, false, 16, 32);
					_curIndex = cframe;
					play("float");
				}
			}
		}
		
		override public function collect():void {
			if (collected) {
				return;
			}
			
			if (SaveCrystal.current.x == 0) {
				Registry.engine.push(new TextState(Font.REDTEXT, "Save Crystals save your progress, and you will return to the most recently touched Save Crystal when you die."));
			}
			
			FlxG.camera.flash(0x66ffffff, 0.5);
			var cframe:uint = frame;
			loadGraphic(Resource.SAVE_ACTIVE, true, false, 16, 32);
			_curIndex = cframe;
			play("float");
			collected = true;
			current.x = tx;
			current.y = ty;
			Registry.save = [tx, ty];
			DataSerializer.save();
			ArcSfxr.play("save");
			
			ArcParticleSystem.emit(Registry.world.particles, "fireball", getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
		}
	}
}
