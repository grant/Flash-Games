package {
	import flash.display.MovieClip;
	import flash.events.Event;
	public class Btn extends MovieClip {
		private const ease:Number = .1;
		private const startScale:Number = .7;//0-1
		private const border:uint=500;
		private var dis:Number;
		private var desw:uint;
		private var desh:uint;
		private var xdis:int;
		private var ydis:int;
		private var cenx:int;
		private var ceny:int;
		private var desx:int;
		private var desy:int;
		public function Btn(px:int,py:int,w:uint,h:uint,dw:uint,dh:uint):void {
			cenx = px;
			ceny = py;
			x = cenx;
			y = ceny;
			width = w;
			height = h;
			desw = dw;
			desh = dh;
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			xdis = Math.abs(stage.mouseX-(stage.stageWidth/2)-x);
			ydis = Math.abs(stage.mouseY-(stage.stageHeight/2)-y);
			dis = Math.sqrt((xdis*xdis)+(ydis*ydis));
			var dw:Number = ((Math.abs(border-dis)/(1/startScale*border)*desw)+(desw/2));
			var dh:Number = ((Math.abs(border-dis)/(1/startScale*border)*desh)+(desh/2));
			width += (dw-width)*ease;
			height += (dh-height)*ease;
		}
		/*Woring
		private function onLoop(e:Event):void {
			width += (desw-width)*ease;
			height += (desh-height)*ease;
			xdis = stage.mouseX-cenx-200;
			ydis = stage.mouseY-ceny-200 ;
			desx = cenx-(xdis/10);
			desy = ceny-(ydis/10);
			x += (desx-x)*ease;
			y += (desy-y)*ease;
		}
		*/
		/*
		private function onLoop(e:Event):void {
			width += (desw-width)*ease;
			height += (desh-height)*ease;
			xdis = stage.mouseX-cenx-200;
			ydis = stage.mouseY-ceny-200 ;
			dragx = Math.abs(xdis/100);
			dragy = Math.abs(ydis/100);
			desx = cenx-(xdis/-dragx);
			desy = ceny-(ydis/-dragy);
			x += (desx-x)*ease;
			y += (desy-y)*ease;
		}
		*/
	}
}