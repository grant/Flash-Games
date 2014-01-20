package com.arc.flixel {
	import org.flixel.FlxG;
	import com.arc.flixel.ButtonState;
	import org.flixel.FlxPoint;
	
	public class ArcButtonGroup extends ArcGroup {
		public function ArcButtonGroup() {
			super();
		}
		
		public function addButton(button:ArcButton):ArcButtonGroup {
			button.setGroup(this);
			this.add(button);
			button.scrollFactor = new FlxPoint(0, 0);
			return this;
		}
		
		public function unselect():void {
			for each(var button:ArcButton in this.members) {
				button.unselect();
			}
		}
	}
}
