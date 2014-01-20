//Notes:
/*
- Inverse Button
- Brightness Slider (Sun, Moon)
- Inverse Button
- Gray Button
- RGB Sliders
- Reset Button
- Snapshot Button ("Snap!")

- Hide all buttons if mouse doesn't move for awhile
*/

package {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	import fl.controls.Button;
	import fl.controls.Slider;
	import fl.controls.SliderDirection;
	import fl.events.SliderEvent;

	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;

	import flash.ui.Mouse;

	import flash.events.*;
	import flash.media.Camera;
	import flash.media.Video;
	
	import flash.system.Security;
	import flash.system.SecurityPanel;

	public class Main extends Sprite {
		//Constants
		private const scale:uint=2;

		private const outsideBorder:uint=10;
		private const sliderWidth:uint=100;
		private const buttonSeparation:uint=20;

		private const mouseTimeOut:uint=30;
		private const fadeInSpeed:Number=.2;//0-1
		private const fadeOutSpeed:Number=.1;//0-1
		
		private const showSnapTime:uint = 20;
		//Variables
		private var showingSnap:uint=0;
		private var mouseTimer:uint=0;
		private var video:Video;
		private var camera:Camera;
		private var bd:BitmapData;
		private var bm:Bitmap;
		//Properties
		private var brightness:int=0;//-100 to 100
		private var inverse:Boolean=false;
		private var gray:Boolean=false;
		private var r:uint=100;
		private var b:uint=100;
		private var g:uint=100;
		//Layers
		private var HUD:Sprite = new Sprite();
		private var webcam:Sprite = new Sprite();
		//Buttons and Sliders
		private var snap:Button = new Button();
		private var redSlide:Slider = new Slider();
		private var greenSlide:Slider = new Slider();
		private var blueSlide:Slider = new Slider();
		private var grayify:Button = new Button();
		private var invert:Button = new Button();
		private var brightnessSlide:Slider = new Slider();
		private var reset:Button = new Button();
		//Text
		private var redText:TextField = new TextField();
		private var greenText:TextField = new TextField();
		private var blueText:TextField = new TextField();
		//Pictures
		private var sun:Picture = new Picture();
		private var moon:Picture = new Picture();
		public function Main() {
			setVideo();
			setLayers();
			setButtons();
		}
		private function setVideo():void {
			stage.scaleMode=StageScaleMode.NO_SCALE;
			stage.align=StageAlign.TOP_LEFT;
			camera=Camera.getCamera();
			if (camera!=null) {
				camera.setQuality(10,100);
				camera.setMode(300,250,100);
				video=new Video(camera.width*1,camera.height*1);
				video.attachCamera(camera);
				addEventListener(Event.ENTER_FRAME,onLoop);
			}
		}
		private function setLayers():void {
			addChild(webcam);
			addChild(HUD);

			bd=new BitmapData(camera.width,camera.height);

			bm=new Bitmap(bd);
			bm.width*=scale;
			bm.height*=scale;
			bm.cacheAsBitmap=true;
			webcam.addChild(bm);
		}
		private function setButtons():void {
			//Snap
			snap.label="Snap!";
			snap.width=50;
			snap.move(stage.stageWidth-outsideBorder-snap.width,stage.stageHeight-outsideBorder-snap.height);
			snap.addEventListener(MouseEvent.CLICK,snapClick);
			HUD.addChild(snap);
			//Red Slide
			redSlide.width=sliderWidth;
			redSlide.move(outsideBorder,outsideBorder+buttonSeparation);
			redSlide.liveDragging=true;
			redSlide.minimum=0;
			redSlide.maximum=100;
			redSlide.snapInterval=1;
			redSlide.tickInterval=10;
			redSlide.value=100;
			redSlide.addEventListener(SliderEvent.THUMB_DRAG,changeRed);
			HUD.addChild(redSlide);
			//Green Slide
			greenSlide.width=sliderWidth;
			greenSlide.move(outsideBorder,redSlide.y+(2*buttonSeparation));
			greenSlide.liveDragging=true;
			greenSlide.minimum=0;
			greenSlide.maximum=100;
			greenSlide.snapInterval=1;
			greenSlide.tickInterval=10;
			greenSlide.value=100;
			greenSlide.addEventListener(SliderEvent.THUMB_DRAG,changeGreen);
			HUD.addChild(greenSlide);
			//Blue Slide
			blueSlide.width=sliderWidth;
			blueSlide.move(outsideBorder,greenSlide.y+(2*buttonSeparation));
			blueSlide.liveDragging=true;
			blueSlide.minimum=0;
			blueSlide.maximum=100;
			blueSlide.snapInterval=1;
			blueSlide.tickInterval=10;
			blueSlide.value=100;
			blueSlide.addEventListener(SliderEvent.THUMB_DRAG,changeBlue);
			HUD.addChild(blueSlide);
			//Grayify
			grayify.label="Black & White";
			grayify.width=sliderWidth;
			grayify.move(outsideBorder,blueSlide.y+buttonSeparation);
			grayify.addEventListener(MouseEvent.CLICK,makeGray);
			HUD.addChild(grayify);
			//Invert
			invert.label="Inverse";
			invert.width=sliderWidth;
			invert.move(outsideBorder,grayify.y+(1.5*buttonSeparation));
			invert.addEventListener(MouseEvent.CLICK,makeInverse);
			HUD.addChild(invert);
			//Brightness Slide
			brightnessSlide.direction=SliderDirection.VERTICAL;
			brightnessSlide.height=sliderWidth*1.5;
			brightnessSlide.move(stage.stageWidth-outsideBorder,outsideBorder*3);
			brightnessSlide.liveDragging=true;
			brightnessSlide.minimum=-100;
			brightnessSlide.maximum=100;
			brightnessSlide.snapInterval=1;
			brightnessSlide.tickInterval=20;
			brightnessSlide.value=0;
			brightnessSlide.addEventListener(SliderEvent.THUMB_DRAG,changeBrightness);
			HUD.addChild(brightnessSlide);
			//Reset
			reset.label="Reset";
			reset.width=sliderWidth;
			reset.move(outsideBorder,invert.y+(1.5*buttonSeparation));
			reset.addEventListener(MouseEvent.CLICK,resetAll);
			HUD.addChild(reset);
			//Text
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.bold=true;
			txtFormat.color=0xFFFFFF;
			txtFormat.font="Verdana";
			txtFormat.size=10;

			redText.defaultTextFormat=txtFormat;
			redText.x = outsideBorder-(sliderWidth/2);
			redText.y=redSlide.y-buttonSeparation;
			redText.autoSize=TextFieldAutoSize.CENTER;
			redText.selectable=false;
			redText.mouseEnabled=false;
			redText.width=sliderWidth;
			redText.height=10;
			redText.text="Red";
			HUD.addChild(redText);
			//greenText.move(outsideBorder,greenSlide.y);
			greenText.defaultTextFormat=txtFormat;
			greenText.x = outsideBorder-(sliderWidth/2);
			greenText.y=greenSlide.y-buttonSeparation;
			greenText.autoSize=TextFieldAutoSize.CENTER;
			greenText.selectable=false;
			greenText.mouseEnabled=false;
			greenText.width=sliderWidth;
			greenText.height=10;
			greenText.text="Green";
			HUD.addChild(greenText);
			//blueText.move(outsideBorder,blueSlide.y);
			blueText.defaultTextFormat=txtFormat;
			blueText.x = outsideBorder-(sliderWidth/2);
			blueText.y=blueSlide.y-buttonSeparation;
			blueText.autoSize=TextFieldAutoSize.CENTER;
			blueText.selectable=false;
			blueText.mouseEnabled=false;
			blueText.width=sliderWidth;
			blueText.height=10;
			blueText.text="Blue";
			HUD.addChild(blueText);
			//Pictures
			sun.gotoAndStop(1);
			sun.x=brightnessSlide.x-2;
			sun.y=brightnessSlide.y-8;
			sun.width=15;
			sun.height=15;
			HUD.addChild(sun);

			moon.gotoAndStop(2);
			moon.x=brightnessSlide.x-2;
			moon.y = brightnessSlide.y+(brightnessSlide.height*2);
			moon.width=10;
			moon.height=10;
			HUD.addChild(moon);
			//Events
			stage.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoving);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,mouseMoving);
			stage.addEventListener(MouseEvent.MOUSE_UP,mouseMoving);
			HUD.addEventListener(Event.ENTER_FRAME,mouseMoveCheck);
		}
		private function snapClick(e:MouseEvent):void {
			showingSnap=showSnapTime;
		}
		private function changeRed(e:SliderEvent):void {
			r=e.value;
		}
		private function changeGreen(e:SliderEvent):void {
			g=e.value;
		}
		private function changeBlue(e:SliderEvent):void {
			b=e.value;
		}
		private function makeGray(e:MouseEvent):void {
			gray=gray?false:true;
		}
		private function makeInverse(e:MouseEvent):void {
			inverse=inverse?false:true;
		}
		private function changeBrightness(e:SliderEvent):void {
			brightness=e.value;
		}
		private function resetAll(e:MouseEvent):void {
			redSlide.value=100;
			greenSlide.value=100;
			blueSlide.value=100;
			brightnessSlide.value=0;
			r=100;
			g=100;
			b=100;
			brightness=0;
			inverse=false;
			gray=false;
		}
		private function mouseMoving(e:MouseEvent):void {
			mouseTimer=0;
			if(camera.muted){
				Security.showSettings(SecurityPanel.PRIVACY);
			}
		}
		private function mouseMoveCheck(e:Event):void {
			if (mouseTimer===mouseTimeOut) {//timed out
				if (HUD.alpha>0) {
					HUD.alpha-=fadeOutSpeed;
					Mouse.hide();
				}
			} else {
				mouseTimer++;
				if (HUD.alpha<1) {
					HUD.alpha+=fadeInSpeed;
					Mouse.show();
				}
			}
		}
		private function onLoop(e:Event):void {
			if (showingSnap===0) {
				bd.draw(video);

				for (var a:uint = 0; a<bd.width; a++) {
					for (var c:uint = 0; c<bd.height; c++) {
						var red:uint=Math.ceil(bd.getPixel(a,c)>>16);
						var green:uint = Math.ceil((bd.getPixel(a,c)-(red<<16))>>8);
						var blue:uint = bd.getPixel(a,c)-(red<<16)-(green<<8);
						if (brightness!=0) {
							if (brightness>0) {
								var dred:uint=255-red;
								var dgreen:uint=255-green;
								var dblue:uint=255-blue;
								red += dred*(brightness/100);
								green += dgreen*(brightness/100);
								blue += dblue*(brightness/100);
							} else {
								red += red*(brightness/100);
								green += green*(brightness/100);
								blue += blue*(brightness/100);
							}
						}
						if (inverse) {
							red=Math.abs(red-255);
							green=Math.abs(green-255);
							blue=Math.abs(blue-255);
						}
						red*=(r/100);
						green*=(g/100);
						blue*=(b/100);
						var finalColor:uint=0;
						if (gray) {
							//Prevents glitch
							if (r==0) {
								r=1;
							}
							if (g==0) {
								g=1;
							}
							if (b==0) {
								b=1;
							}
							var grey:uint = Math.round((red+green+blue)/3);
							red=grey;
							green=grey;
							blue=grey;
						}
						if (r) {
							finalColor+=(red<<16);
						}
						if (g) {
							finalColor+=(green<<8);
						}
						if (b) {
							finalColor+=blue;
						}
						bd.setPixel(a,c,finalColor);
					}
				}
			} else {
				if(showingSnap==1){
					enableAll();
				}
				showingSnap--;
			}
		}
		private function enableAll():void {
			snap.enabled=true;
			redSlide.enabled=true;
			greenSlide.enabled=true;
			blueSlide.enabled=true;
			grayify.enabled=true;
			invert.enabled=true;
			brightnessSlide.enabled=true;
		}
		private function disableAll():void {
			snap.enabled=false;
			redSlide.enabled=false;
			greenSlide.enabled=false;
			blueSlide.enabled=false;
			grayify.enabled=false;
			invert.enabled=false;
			brightnessSlide.enabled=false;
		}
	}
}