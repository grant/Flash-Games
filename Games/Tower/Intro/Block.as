package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Block extends MovieClip {
		private var a:uint;
		private var b:uint;
		private var wid:uint;
		private var hei:uint;
		private var spacing:uint;
		private var size:uint;
		
		public var par:MovieClip;
		public function Block(xpos:uint,ypos:uint,w:uint,h:uint,space:uint,s:uint) {
			a = xpos;
			b = ypos;
			wid = w;
			hei = h;
			spacing = space;
			size = s;
			addEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			x = (stage.stageWidth/2)-((wid*(spacing+size))/2)+(a*(spacing+size));
			y = ((stage.stageHeight)-((spacing+size)*hei))+(b*(size+spacing))+spacing;
			width = size;
			height = size;
			
			visible = false;
			if(b===hei-1){
				if(par.startSize%2==1){//if odd
					if(a+1>=Math.ceil(wid/2)-Math.floor(par.startSize/2)){
						if(a+1<=(wid-par.startSize)/2+par.startSize){
							visible = true;
						}
					}
				} else {//if even
					if(a+1>(wid/2)-(par.startSize/2)){
						if(a+1<=(wid+par.startSize)/2){
							visible = true;
						}
					}
				}
			}
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
	}
}