//par:Circuit
package {
	import flash.display.MovieClip;
	public class DisplayMap extends MovieClip {
		//constructors
		private var px:int;
		private var py:int;
		private var wid:uint;
		private var hei:uint;
		private var size:uint;//size x size dimension of a single tile
		//variables
		private var displayMap:Array;//displayed map
		private var map:Map;//current map data
		
		private var texts:Array = new Array();//Volts and Ohms for tiles array of objects (you should remove all childs and add childs when redrawing)
		//layers
		private var tileLayer:MovieClip;//tiles
		private var textLayer:MovieClip;//Volts and Ohms for tiles
		
		public function DisplayMap(px:int,py:int,wid:uint,hei:uint,size:uint):void {
			this.px = px;
			this.py = py;
			this.wid = wid;
			this.hei = hei;
			this.size = size;
			
			x = px;
			y = py;
			setLayers();
		}
		
		//sets the layers up
		private function setLayers():void {
			tileLayer = new MovieClip();
			textLayer = new MovieClip();
			
			addChild(tileLayer);
			addChild(textLayer);
		}
		
		//adds a map
		public function addMap(m:Map):void {
			map = m;
			display();
		}
		
		//displays the display map
		private function display():void {
			displayMap = new Array();
			for(var i:uint = 0;i<hei;++i) {//y
				displayMap[i] = new Array();
				for(var j:uint = 0;j<wid;++j) {//x
					//j=x,i=y
					var thisTile:Array = getAppropriateTile(j,i);//gets the tile id and rotation of the map tile
					if(thisTile[0]==1||thisTile[0]==4) {//battery or resistor
						//add text object here
						var unit:String = (thisTile[0]==1)?"Ω":"V";
						texts.push(new TileText((j*size),(i*size),toTextNum(map.getElement(j,i)),unit));
						textLayer.addChild(texts[texts.length-1]);
					}
					displayMap[i][j] = new Tile(thisTile[0],thisTile[1],(j*size),(i*size),size);
					tileLayer.addChild(displayMap[i][j]);
				}
			}
		}
		
		//gets the appropriate tile
		private function getAppropriateTile(mapX:uint,mapY:uint):Array {
			var a:Array = new Array();//[0] = tileId,[1] = rotation
			var tilePieceId:uint = toTileNum(map.getElement(mapX,mapY));
			
			var hasLeft:Boolean = map.hasLeft(mapX,mapY);
			var hasRight:Boolean = map.hasRight(mapX,mapY);
			var hasTop:Boolean = map.hasTop(mapX,mapY);
			var hasBottom:Boolean = map.hasBottom(mapX,mapY);
			
			/*Legend
			0 - empty
			1 - resistor
			2 - line
			3 - bl turn
			4 - volt
			5 - T
			6 - +
			*/
			switch(tilePieceId) {
				case 0:
					a[0] = tilePieceId;
					a[1] = 0;
					break;
				case 1:
					a[0] = tilePieceId;
					if(hasTop&&hasBottom) {
						a[1] = 90;
					} else {
						a[1] = 0;
					}
					break;
				case 2:
					if(hasLeft&&hasRight) {//horizontal
						if(hasTop) {
							if(hasBottom) {
								a[0] = 6;
								a[1] = 0;
							} else {//l,r,t
								a[0] = 5;
								a[1] = 180;
							}
						} else if(hasBottom) {//l,r,b
							a[0] = 5;
							a[1] = 0;
						} else {
							a[0] = 2;
							a[1] = 0;
						}
					} else if(hasTop&&hasBottom) {//vertical
						if(hasLeft) {
							if(hasRight) {
								a[0] = 6;
								a[1] = 0;
							} else {//l,t,b
								a[0] = 5;
								a[1] = 90;
							}
						} else if(hasRight) {//r,t,b
							a[0] = 5;
							a[1] = 270;
						} else {//vert
							a[0] = 2;
							a[1] = 90;
						}
					} else if(hasLeft&&hasBottom) {//corners
					 	a[0] = 3;
						a[1] = 0;
					} else if(hasLeft&&hasTop) {//corners
						a[0] = 3;
						a[1] = 90;
					} else if(hasRight&&hasTop) {//corners
						a[0] = 3;
						a[1] = 180;
					} else if(hasRight&&hasBottom) {//corners
						a[0] = 3;
						a[1] = 270;
					} else if(hasBottom||hasTop) {//one sided vert
						a[0] = 2;
						a[1] = 90;
					} else {//one sided horizontal
						a[0] = 2;
						a[1] = 0;
					}
					break;
				case 4:
					a[0] = 4;
					if(hasTop&&hasBottom) {
						a[1] = 90;
					} else {
						a[1] = 180;
					}
					break;
			}
			return a;
		}
		
		//turns the element number into a tile num
		private function toTileNum(str:String):uint {
			return uint(str.substring(0,1));
		}
		
		//turns the element number into text num
		private function toTextNum(str:String):Number {
			return Number(str.substring(2));
		}
	}
}