package {
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.events.Event;
	public class DebugRect extends MovieClip {
		var rect:Rectangle;
		var time:uint = 0;
		public function DebugRect(rect:Rectangle):void {
			this.rect=rect;
			setup();
		}

		//sets up the rect
		private function setup():void {
			//square
			
			var square:Sprite = new Sprite();
			addChild(square);
			square.graphics.lineStyle(1,0xff0000);
			square.graphics.moveTo((rect.left+rect.right)/2,rect.bottom);
			square.graphics.lineTo((rect.left+rect.right)/2,rect.bottom-(rect.height*.1));
			//square.graphics.beginFill(0x0000FF);
			square.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
			square.graphics.endFill();
			
			//curve to origin
			var line:Shape = new Shape();
			addChild(line);
			line.x = 0;
			line.y = 0;
			line.graphics.lineStyle(2,0);
			line.graphics.curveTo(rect.width/4,rect.height/4,rect.width/2+rect.x,rect.height/2+rect.y);
			/*
			line.x = rect.x;
			line.y = rect.y;
			line.graphics.lineStyle(2,0);
			line.graphics.curveTo(rect.x,rect.y,rect.x/2,rect.y/2);
			*/
		}
		/*
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			if(time==1) {
				removeEventListener(Event.ENTER_FRAME,onLoop);
				MovieClip(parent).removeChild(this);
			} else {
				time++;
			}
		}
		*/
	}
}