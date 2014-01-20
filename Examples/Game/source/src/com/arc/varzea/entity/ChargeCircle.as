package com.arc.varzea.entity {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.flixel.ArcSprite;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;

	public class ChargeCircle extends ArcSprite {	
		private var player:Player;
		public var charged:Boolean;
		
		public function ChargeCircle(player:Player) {
			super(0, 0, Resource.CHARGE);
			this.player = player;
			charged = false;
		}
		
		private function get MAX_CHARGE():Number {
			return 0.8 - Registry.level / 100;
		}
		
		override public function update():void  {
			if (!Registry.fireball) {
				return;
			}
			
			if (player.chargeMeter > 0.15) {
				if (!visible) {
					ArcSfxr.play("chargestart");
				}
				visible = true;
				x = player.getMidpoint().x - width / 2;
				y = player.getMidpoint().y - height / 2;
				alpha = (player.chargeMeter / MAX_CHARGE);
				scale.x = 1 - alpha + 0.1;
				scale.y = 1 - alpha + 0.1;
				
				if (alpha >= 1) {
					scale.x = 0;
					scale.y = 0;
				}
				
				if (alpha >= 1 && !charged) {
					charged = true;
					//ArcSfxr.play("chargecomplete");
					ArcParticleSystem.emit(Registry.world.particles, "charge", getMidpoint().x, getMidpoint().y, 20, 1, 1, 0, -200, 200, -200, 200);
				}
				
			} else {
				visible = false;
				charged = false;
			}
			
			super.update();
		}
		
		override public function draw():void {
			if (!visible) {
				return;
			}
			super.draw();
		}
	}
}
