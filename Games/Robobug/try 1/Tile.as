//a displayed static tile
package {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	public class Tile extends MovieClip {
		private var tileId:uint;
		private var px:uint;
		private var py:uint;
		private var wid:uint;
		private var hei:uint;

		//debug
		var debugMode:Boolean=true;
		public function Tile(tileId:uint,px:uint,py:uint,wid:uint,hei:uint):void {
			this.tileId=tileId;
			this.px=px;
			this.py=py;
			this.wid=wid;
			this.hei=hei;
			setup();
		}

		//sets up the tiles
		private function setup():void {
			x=px*wid;
			y=py*hei;
			width=wid;
			height=hei;
			if (debugMode) {
				var textFormat:TextFormat = new TextFormat();
				textFormat.size=15;
				textFormat.align=TextFormatAlign.CENTER;

				var textBox:TextField = new TextField();
				textBox.defaultTextFormat=textFormat;
				textBox.text=(px)+","+(py)+"\n"+tileId;
				addChild(textBox);

				textBox.border=false;
				textBox.wordWrap=true;
				textBox.width=wid;
				textBox.height=hei;
				textBox.x=0;
				textBox.y=0;
			}
		}
	}
}