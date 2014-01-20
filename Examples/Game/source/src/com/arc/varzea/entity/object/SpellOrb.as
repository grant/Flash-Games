package com.arc.varzea.entity.object {
	import com.arc.flixel.ArcParticleSystem;
	import com.arc.flixel.ArcSfxr;
	import com.arc.varzea.engine.TextState;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	
	public class SpellOrb extends Collectible {
		private var index:uint;
		
		public function SpellOrb(x:uint, y:uint, index:uint) {
			super(x, y);
			loadGraphic(Resource.SPELL_ORB, true, false, 16, 16);
			this.index = index;
			frame = index;
			
			var obtained:Boolean = false;
			switch (index) {
				case 0: obtained = Registry.fireball; break;
				case 1: obtained = Registry.douse; break;
				case 2: obtained = Registry.chill; break;
				case 3: obtained = Registry.gust; break;
				case 4: obtained = Registry.shock; break;
				case 5: obtained = Registry.spire; break;
			}
			
			if (obtained) {
				super.kill();
			}
		}
		
		override public function collect():void {
			switch (index) {
				case 0: Registry.fireball = true; break;
				case 1: Registry.douse = true; break;
				case 2: Registry.chill = true; break;
				case 3: Registry.gust = true; break;
				case 4: Registry.shock = true; break;
				case 5: Registry.spire = true; break;
			}
			
			showMessage();
			ArcSfxr.play("pickup");
			
			kill();
		}
		
		private function showMessage():void {
			var messages:Array = [];
			switch (index) {
				case 0:
					messages = [
						"You've obtained the Fireball spell. Use the mouse to aim and click to shoot. Hold the mouse button down to charge your spell into a stronger version.",
						"I’ve been told I’m different. I suppose it’s true. I was born with an attunement to magic. It’s brought jealousy, anger, and now exile."
					]; break;
				case 1:
					messages = [
						"You've obtained the Douse spell. This is a short range spell that can also douse fires. Press 2 to switch to Douse.",
						"Stepping out I realize how much this place reminds me of home. The biggest difference is this conquerable loneliness."
					]; break;
				case 2:
					messages = [
						"You've obtained the Chill spell. This spell will create frozen paths across water. Press 3 to swtich to Chill.",
						"These monsters appear to have overrun the entire planet. I don’t think anything, or anyone, is left."
					]; break;
				case 3:
					messages = [
						"You've obtained the Gust spell. Press 4 to switch to Gust.",
						null
					]; break;
				case 4:
					messages = [
						"You've obtained the Shock spell. This spell can open doors controlled by electric levers. Press 5 to switch to Shock.",
						"The environments here are very different than home. This leads me to believe I'm on another planet or in another world. Suddenly I'm overcome with the fear that I will never see home again."
					]; break;
				case 5:
					messages = [
						"You've obtained the Spire spell. This spell can be used to break through crushed blocks. Press 6 to switch to Spire.",
						"Perhaps these monsters are overcome with aggression due to loneliness. Perhaps I'll become one of them."
					]; break;
			}
			
			Registry.engine.push(new TextState(Font.REDTEXT, messages[0]));
			if (messages[1] != null) {
				Registry.engine.push(new TextState(Font.GRAY, messages[1]));
			}
		}
		
		override public function kill():void {
			var particle:String;
			switch (index) {
				case 0: particle = "fireball"; break;
				case 1: particle = "douse"; break;
				case 2: particle = "chill"; break;
				case 3: particle = "gust"; break;
				case 4: particle = "shock"; break;
				case 5: particle = "spire"; break;
			}
			
			ArcParticleSystem.emit(Registry.world.particles, particle, getMidpoint().x, getMidpoint().y, 20, 4, 1, 00, -80, 80, -80, 80);
			super.kill();
		}
	}
}
