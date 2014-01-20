package com.arc.flixel {
	import com.arc.varzea.entity.object.SaveCrystal;
	import com.arc.varzea.util.Registry;
	
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import org.flixel.FlxPoint;
	
	public class DataSerializer {
		/** Internal state of the serializer */
		private static var state:Array;
		
		/**
		 * Resets all saved data.
		 */
		public static function reset():void {
			Registry.reset();
			save();
		}
		
		/**
		 * Saves the game.
		 */
		public static function save():void {
			try {
				var so:SharedObject = SharedObject.getLocal("arzea");
				so.data.save = serialize()
				so.flush();
				trace("Successfully saved game");
			} catch (error:Error) {
				trace("Error saving game: " + error);
			}
		}
		
		/**
		 * Loads the game.
		 */
		public static function load():void {
			try {
				var so:SharedObject = SharedObject.getLocal("arzea");
				if (so != null && so.data != null && so.data.save != null) {
					unserialize(so.data.save);
				}
				trace("Successfully loaded game");
			} catch (error:Error) {
				trace("Error loading game: " + error);
			}
		}
		
		/**
		 * Takes the data stored in the static Data class and serializes it to an encrypted string
		 * to be stored in the SharedObject.
		 * @return	the encrypted string containing save data
		 */
		public static function serialize():String {
			state = [];
			
			var spells:Array = [Registry.fireball ? 1 : 0, Registry.douse ? 1 : 0, Registry.chill ? 1 : 0, Registry.gust ? 1 : 0, Registry.shock ? 1 : 0, Registry.spire ? 1 : 0];
			write(spells);
			write(Registry.keys);
			write(Registry.doublejump);
			write((int)(Registry.time * 1000));
			write(Registry.hearts);
			write(Registry.jumps);
			write(Registry.speeds);
			write(Registry.save);
			write(Registry.sound);
			write(Registry.music);
			write(Registry.level);
			write(Registry.xp);
			write(Registry.xpm);
			
			var data:String = state.join(",");
			trace("Serialized data: ", data);
			return data;
		}
		
		/**
		 * Given an encrypted save string, decrypts it and uses it to populate the static Data class.
		 * @param	data	the encrypted string containing save data
		 */
		public static function unserialize(data:String):void {
			state = data.split(",");
			
			var spells:Array = read(Array, 6);
			Registry.fireball = spells[0];
			Registry.douse = spells[1];
			Registry.chill = spells[2];
			Registry.gust = spells[3];
			Registry.shock = spells[4];
			Registry.spire = spells[5];
			
			Registry.keys = read(Array, 6);
			Registry.doublejump = read(int);
			Registry.time = read(int) / 1000.0;
			Registry.hearts = read(Array, 5);
			Registry.jumps = read(Array, 5);
			Registry.speeds = read(Array, 5);
			Registry.save = read(Array, 2);
			SaveCrystal.current = new FlxPoint(Registry.save[0], Registry.save[1]);
			
			Registry.sound = read(int);
			Registry.music = read(int);
			
			var level:int = read(int);
			if (level > 0) {
				Registry.level = level;
				Registry.xp = read(int);
				Registry.xpm = read(int);
			}
		}
		
		/**
		 * Writes a single value to the internal state buffer, recursively writing it if it is an array.
		 * @param	value	the value to write to the internal state buffer
		 */
		public static function write(value:*):void {
			if (value is Array) {
				//trace("writing array: ", value);
				for each(var v:* in value) {
					write(v);
				}
			} else if (value is Number || value is int || value is String) {
				//trace("writing value: ", value);
				state.push(value);
			} else {
				trace("Error writing value '" + value + "' with type '" + typeof value + "'");
			}
		}
		
		/**
		 * Reads a value from the internal state buffer of the given type. If the type is Array, uses length to
		 * detemine how many values to read into the returned array.
		 * @param	type	type of the value to read
		 * @param	length	length of the array to read, if type is Array
		 * @return	the read value of the given type
		 */
		public static function read(type:Class, length:int = 0):* {
			switch(type) {
				case int: return parseInt(state.shift()) as int; break;
				case String: return state.shift() as String; break;
				case Array: var a:Array = []; for (var i:int = 0; i < length; i++) { a.push(parseInt(state.shift())); } return a as Array; break;
			}
			
			trace("Error reading value of type '" + type + "' and length '" + length + "'");
			return null;
		}
	}
}
