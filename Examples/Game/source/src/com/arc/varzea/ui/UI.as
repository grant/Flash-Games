package com.arc.varzea.ui {
	import com.arc.flixel.ArcGroup;
	import com.arc.flixel.ArcSprite;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.resource.Font;
	import com.arc.varzea.resource.Resource;
	import com.arc.varzea.util.Registry;
	
	import org.flixel.FlxBitmapText;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;

	public class UI extends ArcGroup {
		private var heartMeter:ArcSprite;
		private var jumpMeter:ArcSprite;
		private var speedMeter:ArcSprite;
		private var heartBar:HeartBar;
		private var spell:ArcSprite;
		private var xpframe:ArcSprite;
		private var xpbar:ArcSprite;
		private var level:FlxBitmapText;
		
		public function UI() {
			this.add(heartMeter = new ArcSprite(300, 216));
			this.add(jumpMeter = new ArcSprite(320, 216));
			this.add(speedMeter = new ArcSprite(340, 216));
			this.add(heartBar = new HeartBar);
			this.add(spell = new ArcSprite(7, 216));
			this.add(xpframe = new ArcSprite(4, 232, Resource.XPFRAME));
			this.add(xpbar = new ArcSprite(6, 234, Resource.XPBAR));
			this.add(level = new FlxBitmapText(6, 226, Font.GOLD, "LEVEL 12", "right", 60));
			
			heartMeter.loadGraphic(Resource.HEART_METER, true, false, 18, 23);
			jumpMeter.loadGraphic(Resource.JUMP_METER, true, false, 18, 23);
			speedMeter.loadGraphic(Resource.SPEED_METER, true, false, 18, 23);
			spell.loadGraphic(Resource.SPELL_ORB, true, false, 16, 16);
			
			xpbar.origin.x = xpbar.origin.y = 0;
			
			setAll("scrollFactor", new FlxPoint(0, 0), true);
		}
		
		override public function update():void {
			xpbar.scale.x = Registry.xp / Registry.xpm;
			
			switch (Registry.world.player.spell) {
				case Spell.FIREBALL: spell.frame = 0; break;
				case Spell.DOUSE: spell.frame = 1; break;
				case Spell.CHILL: spell.frame = 2; break;
				case Spell.GUST: spell.frame = 3; break;
				case Spell.SHOCK: spell.frame = 4; break;
				case Spell.SPIRE: spell.frame = 5; break;
			}
			
			level.text = "LEVEL " + Registry.level;
			
			heartMeter.frame = Registry.numHearts();
			jumpMeter.frame = Registry.numJumps();
			speedMeter.frame = Registry.numSpeeds();
		}
	}
}
