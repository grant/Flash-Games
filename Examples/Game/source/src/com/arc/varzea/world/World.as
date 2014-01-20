package com.arc.varzea.world {
	import com.arc.flixel.ArcSprite;
	import com.arc.varzea.entity.Player;
	import com.arc.varzea.entity.projectile.Chill;
	import com.arc.varzea.entity.projectile.Douse;
	import com.arc.varzea.entity.projectile.Fireball;
	import com.arc.varzea.entity.projectile.Spell;
	import com.arc.varzea.entity.projectile.Spire;
	import com.arc.varzea.resource.Resource;
	
	import flash.display.BitmapData;
	
	import org.flixel.FlxObject;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;

	public class World extends FlxTilemap {
		public function World(mapString:String) {
			super();
			
			loadMap(mapString, Resource.TILES, Tile.WIDTH, Tile.HEIGHT, OFF, 0, 1, 100);
			setupTiles();
		}
		
		private function setupTiles():void {
			setTileProperties(140, NONE);
			setTileProperties(142, NONE);
			
			setWater();
			setLava();
			setCrumble();
		}
		
		private function setCrumble():void {
			setTileProperties(187, ANY, crumbleCallback, Spire);
		}
		
		private function crumbleCallback(tile:FlxTile, object:FlxObject):void {
			setTileByIndex(tile.mapIndex, 0);
		}
		
		private function setWater():void {
			setTileProperties(40, NONE, waterCallback, Player);
			setTileProperties(20, NONE, freezeCallback, Chill, 3);
			setTileProperties(186, ANY, meltCallback, Fireball, 3);
		}
		
		private function waterCallback(tile:FlxTile, object:FlxObject):void {
			(object as Player).water = 0.1;
		}
		
		private function setLava():void {
			setTileProperties(43, NONE, lavaCallback, Player);
		}
		
		private function lavaCallback(tile:FlxTile, object:FlxObject):void {
			(object as Player).kill();
		}
		
		private function freezeCallback(tile:FlxTile, object:FlxObject):void {
			setTileByIndex(tile.mapIndex, 186);
			(object as Spell).kill();
		}
		
		private function meltCallback(tile:FlxTile, object:FlxObject):void {
			setTileByIndex(tile.mapIndex, 21);
			(object as Spell).kill();
		}
	}
}
