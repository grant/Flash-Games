//fix circle and rect small area thick thickness
package {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.filters.DropShadowFilter;
	import fl.controls.ColorPicker;
	import fl.events.ColorPickerEvent;
	import fl.controls.Slider;
	import fl.events.SliderEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	public class main extends Sprite {
		private const sW:uint=900;//stage width
		private const sH:uint=500;//stage height

		private var drawType:String="line";//"line","rect","circle","brush"
		private var shapeHolder:Array = new Array();

		private var bgColor:uint=0xFFFFFF;
		private var menuLineColor:uint=0x000000;
		private var menuLineThickness:Number=4;
		private var menuColor:uint=0xCC0000;
		private var menuHeight:uint=100;

		private var paddingX:uint=15;
		private var iconPadding:Number=.2;//0 to .5

		private var buttonRoundedEdge:int=30;
		private var button0Size:uint=70;//large
		private var buttonSize:uint=50;//normal
		private var button2Size:uint=30;//small

		private var buttonShadow:DropShadowFilter=new DropShadowFilter(5,45,0x000000,.9,5,5,.8,1,false,false,false);
		private var glow:GlowFilter=new GlowFilter(0xFFCC00,1,20,20,1.5,1,false,false);

		private var lineToolBTN:Sprite = new Sprite();
		private var lineTool:Shape = new Shape();//1st button
		private var lineToolColor:uint=0xFF9900;

		private var rectToolBTN:Sprite = new Sprite();
		private var rectTool:Shape = new Shape();//2nd button
		private var rectToolColor:uint=0x009900;
		private var rectIconColor:uint=0x990099;

		private var circleToolBTN:Sprite = new Sprite();
		private var circleTool:Shape = new Shape();//3rd button
		private var circleToolColor:uint=0x0066FF;
		private var circleIconColor:uint=0xFF9900;
		private var circleIconOffset:Number=.10;

		private var brushToolBTN:Sprite = new Sprite();
		private var brushTool:Shape = new Shape();//4th button
		private var brushToolColor:uint=0x66FF66;
		private var brushIconColor:uint=0xFF66FF;

		private var lineColorPicker:ColorPicker = new ColorPicker();
		private var fillColorPicker:ColorPicker = new ColorPicker();
		private var disabledColorPickerAlpha:Number=.2;
		private var lineColorClosed:Boolean=true;
		private var fillColorClosed:Boolean=true;
		private var defaultLineColor:uint=0x000000;
		private var defaultFillColor:uint=0xFF0000;
		private var disableDraw:Boolean=false;

		private var lineColor:uint=defaultLineColor;
		private var fillColor:uint=defaultFillColor;
		private var thickness:Number=menuLineThickness;
		private var lineAlpha:Number=1;
		private var fillAlpha:Number=1;

		private var lineAlphaSlider:Slider = new Slider();
		private var lineThicknessSlider:Slider = new Slider();
		private var fillAlphaSlider:Slider = new Slider();
		private var roundEdgeSlider:Slider = new Slider();
		private var roundEdge:uint=30;
		private var disabledSlider:Number=.2;
		private var preShapeAlpha:Number=.8;

		private var preview:Shape = new Shape();

		private var shadows:Boolean=true;
		private var shadowBTN:Sprite = new Sprite();
		private var shadowShape:Shape = new Shape();
		private var shadowColor:uint=0xFFFF00;
		private var shadowIconColor:uint=0x996699;

		private var clearBTN:Sprite = new Sprite();
		private var clearShape:Shape = new Shape();
		private var clearColor:uint=0xFFFFFF;

		private var undoBTN:Sprite = new Sprite();
		private var undo:Shape = new Shape();
		private var undoColor:uint=0x33CC00;

		private var multiUndoBTN:Sprite = new Sprite();
		private var multiUndo:Shape = new Shape();
		private var multiUndoColor:uint=0x0033FF;

		private var cancelBTN:Sprite = new Sprite();
		private var cancel:Shape = new Shape();
		private var cancelColor:uint=0xFF0000;

		private var startedLine:Boolean=false;

		private var startedRect:Boolean=false;
		private var rectColor:uint=0xFF0000;

		private var startedCircle:Boolean=false;
		private var circleColor:uint=0x00FFFF;
		private var circleEdgeColor:uint=0x008888;
		private var circleEdgeLineColor:uint=0x333333;

		private var startX;
		private var startY;
		
		private var myMenu:ContextMenu = new ContextMenu();
		private var rightClick:ContextMenuItem = new ContextMenuItem("Made by Creeplover");
		private var request:URLRequest = new URLRequest("http://www.kongregate.com/accounts/creeplover");
		public function main() {
			setUp();
			changePreview();
			stage.addEventListener(MouseEvent.CLICK,onClick);
		}
		private function linkKong(e:ContextMenuEvent):void {
			navigateToURL(request, '_blank');
		}
		private function setUp():void {
			stage.frameRate=30;
			myMenu.customItems.push(rightClick);
			this.contextMenu = myMenu;
			rightClick.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, linkKong);

			//BACKGROUND//
			var bgRect:Shape = new Shape();//background color
			bgRect.graphics.beginFill(bgColor);
			bgRect.graphics.drawRect(0,0,sW,sH);
			bgRect.graphics.endFill();
			stage.addChild(bgRect);

			//MENU//
			var menu:Shape = new Shape();
			menu.graphics.lineStyle(menuLineThickness,menuLineColor);
			menu.graphics.beginFill(menuColor);
			menu.graphics.drawRect(0,0,sW,menuHeight);
			menu.graphics.endFill();
			stage.addChild(menu);

			//LINE_TOOL//
			lineToolBTN.addEventListener(MouseEvent.CLICK,onLineClick);
			stage.addChild(lineToolBTN);
			lineTool.graphics.lineStyle(menuLineThickness,menuLineColor);
			lineTool.graphics.beginFill(lineToolColor);
			lineTool.graphics.drawRoundRect(paddingX,(menuHeight/2)-(buttonSize/2),buttonSize,buttonSize,buttonRoundedEdge);
			lineTool.graphics.endFill();
			lineTool.filters=[buttonShadow,glow];
			lineToolBTN.addChild(lineTool);
			var lineIcon:Shape = new Shape();
			lineIcon.graphics.lineStyle(menuLineThickness,menuLineColor);
			lineIcon.graphics.moveTo(paddingX+(buttonSize*iconPadding),menuHeight/2);
			lineIcon.graphics.lineTo(paddingX+(buttonSize*(1-iconPadding)),menuHeight/2);
			lineToolBTN.addChild(lineIcon);

			//RECT_TOOL//
			rectToolBTN.addEventListener(MouseEvent.CLICK,onRectClick);
			stage.addChild(rectToolBTN);
			rectTool.graphics.lineStyle(menuLineThickness,menuLineColor);
			rectTool.graphics.beginFill(rectToolColor);
			rectTool.graphics.drawRoundRect((paddingX*2)+buttonSize,(menuHeight/2)-(buttonSize/2),buttonSize,buttonSize,buttonRoundedEdge);
			rectTool.graphics.endFill();
			rectTool.filters=[buttonShadow];
			rectToolBTN.addChild(rectTool);
			var rectIcon:Shape = new Shape();
			rectIcon.graphics.lineStyle(menuLineThickness,menuLineColor);
			rectIcon.graphics.beginFill(rectIconColor);
			rectIcon.graphics.drawRoundRect(((paddingX*2)+buttonSize)+(buttonSize*iconPadding),((menuHeight/2)-(buttonSize/2))+(buttonSize*iconPadding),buttonSize*(1-(2*iconPadding)),buttonSize*(1-(2*iconPadding)),buttonRoundedEdge*((buttonSize*(1-(2*iconPadding)))/buttonSize));//last:buttonRoundedEdge(for a normal button)/width
			rectIcon.graphics.endFill();
			rectToolBTN.addChild(rectIcon);

			//CIRCLE_TOOL//
			circleToolBTN.addEventListener(MouseEvent.CLICK,onCircleClick);
			stage.addChild(circleToolBTN);
			circleTool.graphics.lineStyle(menuLineThickness,menuLineColor);
			circleTool.graphics.beginFill(circleToolColor);
			circleTool.graphics.drawRoundRect((paddingX*3)+(buttonSize*2),(menuHeight/2)-(buttonSize/2),buttonSize,buttonSize,buttonRoundedEdge);
			circleTool.graphics.endFill();
			circleTool.filters=[buttonShadow];
			circleToolBTN.addChild(circleTool);
			var circleIcon:Shape = new Shape();
			circleIcon.graphics.lineStyle(menuLineThickness,menuLineColor);
			circleIcon.graphics.beginFill(circleIconColor);
			circleIcon.graphics.drawCircle((paddingX*3)+(buttonSize*2.5),menuHeight/2,(buttonSize/2)*((1-(iconPadding*2))));
			circleIcon.graphics.endFill();
			circleToolBTN.addChild(circleIcon);

			//BRUSH_TOOL//
			brushToolBTN.addEventListener(MouseEvent.CLICK,onBrushClick);
			stage.addChild(brushToolBTN);
			brushTool.graphics.lineStyle(menuLineThickness,menuLineColor);
			brushTool.graphics.beginFill(brushToolColor);
			brushTool.graphics.drawRoundRect((paddingX*4)+(buttonSize*3),(menuHeight/2)-(buttonSize/2),buttonSize,buttonSize,buttonRoundedEdge);
			brushTool.graphics.endFill();
			brushTool.filters=[buttonShadow];
			brushToolBTN.addChild(brushTool);
			var brushIcon1:Shape = new Shape();
			var brushIcon2:Shape = new Shape();
			brushIcon1.graphics.lineStyle(menuLineThickness,menuLineColor);
			brushIcon2.graphics.lineStyle(menuLineThickness,menuLineColor);
			brushIcon1.graphics.moveTo((paddingX*4)+(buttonSize*3)+(iconPadding*buttonSize),(menuHeight/2)-(buttonSize/2)+(iconPadding*buttonSize));
			brushIcon1.graphics.curveTo((paddingX*4)+(buttonSize*3)+(iconPadding*buttonSize),menuHeight/2,(paddingX*4)+(buttonSize*3.5),menuHeight/2);
			brushIcon2.graphics.moveTo((paddingX*4)+(buttonSize*3.5),menuHeight/2);
			brushIcon2.graphics.curveTo((paddingX*4)+(buttonSize*3)+((1-iconPadding)*buttonSize),menuHeight/2,(paddingX*4)+(buttonSize*3)+((1-iconPadding)*buttonSize),(menuHeight/2)-(buttonSize/2)+(1-iconPadding)*buttonSize);
			stage.addChild(brushIcon1);
			stage.addChild(brushIcon2);

			//LINE_COLOR_PICKER//
			lineColorPicker.selectedColor=defaultLineColor;
			lineColorPicker.addEventListener(ColorPickerEvent.CHANGE,changeLineColor);
			lineColorPicker.addEventListener(Event.OPEN,lineColorOpen);
			lineColorPicker.addEventListener(Event.CLOSE,lineColorClose);
			lineColorPicker.width=button2Size;
			lineColorPicker.height=button2Size;
			lineColorPicker.move((paddingX*5)+(buttonSize*4),(menuHeight-(2*button2Size))/3);
			lineColorPicker.filters=[buttonShadow];
			stage.addChild(lineColorPicker);

			//FILL_COLOR_PICKER//
			fillColorPicker.selectedColor=defaultFillColor;
			fillColorPicker.addEventListener(ColorPickerEvent.CHANGE,changeFillColor);
			fillColorPicker.addEventListener(Event.OPEN,fillColorOpen);
			fillColorPicker.addEventListener(Event.CLOSE,fillColorClose);
			fillColorPicker.width=button2Size;
			fillColorPicker.height=button2Size;
			fillColorPicker.move((paddingX*5)+(buttonSize*4),(((menuHeight-(2*button2Size))/3)*2)+button2Size);
			fillColorPicker.filters=[buttonShadow];
			stage.addChild(fillColorPicker);
			fillColorPicker.alpha=disabledColorPickerAlpha;
			fillColorPicker.enabled=false;

			//LINE_ALPHA_SLIDER//
			lineAlphaSlider.move((paddingX*6)+(buttonSize*4)+button2Size,((menuHeight-20)/4));
			lineAlphaSlider.setSize(sW-((paddingX*6)+(buttonSize*4)+button2Size)-(5*paddingX)-buttonSize-(2*button2Size)-button0Size,0);
			lineAlphaSlider.liveDragging=true;
			lineAlphaSlider.minimum=0;
			lineAlphaSlider.maximum=1;
			lineAlphaSlider.snapInterval=.05;
			lineAlphaSlider.tickInterval=.25;
			lineAlphaSlider.value=1;
			lineAlphaSlider.addEventListener(SliderEvent.THUMB_DRAG,changeLineAlpha);
			stage.addChild(lineAlphaSlider);

			//LINE_THICKNESS_SLIDER//
			lineThicknessSlider.move((paddingX*6)+(buttonSize*4)+button2Size,((menuHeight-20)/4)*2);
			lineThicknessSlider.setSize(sW-((paddingX*6)+(buttonSize*4)+button2Size)-(5*paddingX)-buttonSize-(2*button2Size)-button0Size,0);
			lineThicknessSlider.liveDragging=true;
			lineThicknessSlider.minimum=0;
			lineThicknessSlider.maximum=30;
			lineThicknessSlider.snapInterval=1;
			lineThicknessSlider.tickInterval=10;
			lineThicknessSlider.value=3;
			lineThicknessSlider.addEventListener(SliderEvent.THUMB_DRAG,changeLineThickness);
			stage.addChild(lineThicknessSlider);

			//FILL_ALPHA_SLIDER//
			fillAlphaSlider.move((paddingX*6)+(buttonSize*4)+button2Size,((menuHeight-20)/4)*3);
			fillAlphaSlider.setSize(sW-((paddingX*6)+(buttonSize*4)+button2Size)-(5*paddingX)-buttonSize-(2*button2Size)-button0Size,0);
			fillAlphaSlider.liveDragging=true;
			fillAlphaSlider.minimum=0;
			fillAlphaSlider.maximum=1;
			fillAlphaSlider.snapInterval=.05;
			fillAlphaSlider.tickInterval=.25;
			fillAlphaSlider.value=1;
			fillAlphaSlider.addEventListener(SliderEvent.THUMB_DRAG,changeFillAlpha);
			stage.addChild(fillAlphaSlider);
			fillAlphaSlider.alpha=disabledSlider;
			fillAlphaSlider.enabled=false;

			//FILL_EDGE_SLIDER//
			roundEdgeSlider.move((paddingX*6)+(buttonSize*4)+button2Size,((menuHeight-20)/4)*4);
			roundEdgeSlider.setSize(sW-((paddingX*6)+(buttonSize*4)+button2Size)-(5*paddingX)-buttonSize-(2*button2Size)-button0Size,0);
			roundEdgeSlider.liveDragging=true;
			roundEdgeSlider.minimum=0;
			roundEdgeSlider.maximum=150;
			roundEdgeSlider.snapInterval=5;
			roundEdgeSlider.tickInterval=30;
			roundEdgeSlider.value=roundEdge;
			roundEdgeSlider.addEventListener(SliderEvent.THUMB_DRAG,changeRoundEdge);
			stage.addChild(roundEdgeSlider);
			roundEdgeSlider.alpha=disabledSlider;
			roundEdgeSlider.enabled=false;

			//PREVIEW//
			preview.graphics.lineStyle(menuLineThickness,menuLineColor);
			preview.graphics.beginFill(bgColor);
			preview.graphics.drawRoundRect(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size,(menuHeight/2)-(button0Size/2),button0Size,button0Size,buttonRoundedEdge*(button0Size/buttonSize));
			preview.graphics.endFill();
			preview.filters=[buttonShadow];
			stage.addChild(preview);

			//SHADOW//
			shadowBTN.addEventListener(MouseEvent.CLICK,onShadowClick);
			shadowBTN.addEventListener(MouseEvent.MOUSE_DOWN,glowOn);
			shadowBTN.addEventListener(MouseEvent.MOUSE_UP,glowOff);
			shadowBTN.addEventListener(MouseEvent.MOUSE_OUT,glowOff);
			stage.addChild(shadowBTN);
			shadowShape.graphics.lineStyle(menuLineThickness,menuLineColor);
			shadowShape.graphics.beginFill(shadowColor);
			shadowShape.graphics.drawRoundRect(sW-(3*paddingX)-buttonSize-(2*button2Size),(menuHeight-(2*button2Size))/3,button2Size,button2Size,buttonRoundedEdge*(button2Size/buttonSize));
			shadowShape.graphics.endFill();
			shadowBTN.filters=[buttonShadow];
			shadowBTN.addChild(shadowShape);
			var shadowIcon:Shape = new Shape();
			shadowIcon.graphics.lineStyle(menuLineThickness,menuLineColor);
			shadowIcon.graphics.beginFill(shadowIconColor);
			shadowIcon.graphics.drawCircle(sW-(3*paddingX)-buttonSize-(1.5*button2Size),(menuHeight-(2*button2Size))/3+(button2Size/2),((button2Size/2)*(1-(3*iconPadding))));
			shadowIcon.graphics.endFill();
			shadowIcon.filters=[buttonShadow];
			shadowBTN.addChild(shadowIcon);

			//CLEAR//
			clearBTN.addEventListener(MouseEvent.CLICK,onClearClick);
			clearBTN.addEventListener(MouseEvent.MOUSE_DOWN,glowOn);
			clearBTN.addEventListener(MouseEvent.MOUSE_UP,glowOff);
			clearBTN.addEventListener(MouseEvent.MOUSE_OUT,glowOff);
			stage.addChild(clearBTN);
			clearShape.graphics.lineStyle(menuLineThickness,menuLineColor);
			clearShape.graphics.beginFill(clearColor);
			clearShape.graphics.drawRoundRect(sW-(2*paddingX)-buttonSize-button2Size,(menuHeight-(2*button2Size))/3,button2Size,button2Size,buttonRoundedEdge*(button2Size/buttonSize));
			clearShape.graphics.endFill();
			clearBTN.addChild(clearShape);
			var txtFormat:TextFormat = new TextFormat();
			txtFormat.bold=true;
			txtFormat.color=menuLineColor;
			txtFormat.font="Verdana";
			txtFormat.size=button2Size/1.5;
			var txtField:TextField = new TextField();
			txtField.defaultTextFormat=txtFormat;
			txtField.x = sW-(2*paddingX)-buttonSize-button2Size;
			txtField.y = (menuHeight-(2*button2Size))/3;
			txtField.width=button2Size;
			txtField.height=button2Size/2;
			txtField.autoSize=TextFieldAutoSize.CENTER;
			txtField.selectable=false;
			txtField.mouseEnabled=false;
			txtField.text="CL";
			clearBTN.filters=[buttonShadow];
			stage.addChild(txtField);

			//UNDO//
			undoBTN.addEventListener(MouseEvent.CLICK,onUndoClick);
			undoBTN.addEventListener(MouseEvent.MOUSE_DOWN,glowOn);
			undoBTN.addEventListener(MouseEvent.MOUSE_UP,glowOff);
			undoBTN.addEventListener(MouseEvent.MOUSE_OUT,glowOff);
			stage.addChild(undoBTN);
			undo.graphics.lineStyle(menuLineThickness,menuLineColor);
			undo.graphics.beginFill(undoColor);
			undo.graphics.drawRoundRect(sW-(2*paddingX)-buttonSize-button2Size,(((menuHeight-(2*button2Size))/3)*2)+button2Size,button2Size,button2Size,buttonRoundedEdge*(button2Size/buttonSize));
			undoBTN.filters=[buttonShadow];
			undoBTN.addChild(undo);
			var smallArrow:Shape = new Shape();
			smallArrow.graphics.lineStyle(menuLineThickness,menuLineColor);
			smallArrow.graphics.moveTo(sW-(2*paddingX)-buttonSize-(iconPadding*button2Size),(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			smallArrow.graphics.lineTo(sW-(2*paddingX)-buttonSize-((1-iconPadding)*button2Size),(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			undoBTN.addChild(smallArrow);
			var smallArrow1:Shape = new Shape();
			smallArrow1.graphics.lineStyle(menuLineThickness,menuLineColor);
			smallArrow1.graphics.moveTo(sW-(2*paddingX)-buttonSize-((1-iconPadding)*button2Size),(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			smallArrow1.graphics.lineTo(sW-(2*paddingX)-buttonSize-(button2Size/2),(((menuHeight-(2*button2Size))/3)*2)+(button2Size*iconPadding)+button2Size);
			undoBTN.addChild(smallArrow1);
			var smallArrow2:Shape = new Shape();
			smallArrow2.graphics.lineStyle(menuLineThickness,menuLineColor);
			smallArrow2.graphics.moveTo(sW-(2*paddingX)-buttonSize-((1-iconPadding)*button2Size),(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			smallArrow2.graphics.lineTo(sW-(2*paddingX)-buttonSize-(button2Size/2),(((menuHeight-(2*button2Size))/3)*2)+((1-iconPadding)*button2Size)+button2Size);
			undoBTN.addChild(smallArrow2);

			//MULTI_UNDO//
			multiUndoBTN.addEventListener(MouseEvent.CLICK,onMultiUndoClick);
			multiUndoBTN.addEventListener(MouseEvent.MOUSE_DOWN,glowOn);
			multiUndoBTN.addEventListener(MouseEvent.MOUSE_UP,glowOff);
			multiUndoBTN.addEventListener(MouseEvent.MOUSE_OUT,glowOff);
			stage.addChild(multiUndoBTN);
			multiUndo.graphics.lineStyle(menuLineThickness,menuLineColor);
			multiUndo.graphics.beginFill(multiUndoColor);
			multiUndo.graphics.drawRoundRect(sW-(3*paddingX)-buttonSize-(2*button2Size),(((menuHeight-(2*button2Size))/3)*2)+button2Size,button2Size,button2Size,buttonRoundedEdge*(button2Size/buttonSize));
			multiUndoBTN.filters=[buttonShadow];
			multiUndoBTN.addChild(multiUndo);

			var arrowStem:Shape = new Shape();
			arrowStem.graphics.lineStyle(menuLineThickness,menuLineColor);
			arrowStem.graphics.moveTo(sW-(3*paddingX)-buttonSize-(iconPadding*button2Size)-button2Size,(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			arrowStem.graphics.lineTo(sW-(3*paddingX)-buttonSize-((1-iconPadding)*button2Size)-button2Size,(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			multiUndoBTN.addChild(arrowStem);
			var arrow1:Shape = new Shape();
			arrow1.graphics.lineStyle(menuLineThickness,menuLineColor);
			arrow1.graphics.moveTo(sW-(3*paddingX)-buttonSize-((1-iconPadding)*button2Size)-button2Size,(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			arrow1.graphics.lineTo(sW-(3*paddingX)-buttonSize-button2Size-((1-(2*iconPadding))*button2Size),(((menuHeight-(2*button2Size))/3)*2)+(button2Size*iconPadding)+button2Size);
			multiUndoBTN.addChild(arrow1);
			var arrow2:Shape = new Shape();
			arrow2.graphics.lineStyle(menuLineThickness,menuLineColor);
			arrow2.graphics.moveTo(sW-(3*paddingX)-buttonSize-((1-iconPadding)*button2Size)-button2Size,(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			arrow2.graphics.lineTo(sW-(3*paddingX)-buttonSize-button2Size-((1-(2*iconPadding))*button2Size),(((menuHeight-(2*button2Size))/3)*2)+((1-iconPadding)*button2Size)+button2Size);
			multiUndoBTN.addChild(arrow2);
			var arrow3:Shape = new Shape();
			arrow3.graphics.lineStyle(menuLineThickness,menuLineColor);
			arrow3.graphics.moveTo(sW-(3*paddingX)-buttonSize-((1-(iconPadding*2))*button2Size)-button2Size,(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			arrow3.graphics.lineTo(sW-(3*paddingX)-buttonSize-button2Size-((1-(3*iconPadding))*button2Size),(((menuHeight-(2*button2Size))/3)*2)+(button2Size*iconPadding)+button2Size);
			multiUndoBTN.addChild(arrow3);
			var arrow4:Shape = new Shape();
			arrow4.graphics.lineStyle(menuLineThickness,menuLineColor);
			arrow4.graphics.moveTo(sW-(3*paddingX)-buttonSize-((1-(iconPadding*2))*button2Size)-button2Size,(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			arrow4.graphics.lineTo(sW-(3*paddingX)-buttonSize-button2Size-((1-(3*iconPadding))*button2Size),(((menuHeight-(2*button2Size))/3)*2)+((1-iconPadding)*button2Size)+button2Size);
			multiUndoBTN.addChild(arrow4);
			var arrow5:Shape = new Shape();
			arrow5.graphics.lineStyle(menuLineThickness,menuLineColor);
			arrow5.graphics.moveTo(sW-(3*paddingX)-buttonSize-((1-(iconPadding*3))*button2Size)-button2Size,(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			arrow5.graphics.lineTo(sW-(3*paddingX)-buttonSize-button2Size-((1-(4*iconPadding))*button2Size),(((menuHeight-(2*button2Size))/3)*2)+(button2Size*iconPadding)+button2Size);
			multiUndoBTN.addChild(arrow5);
			var arrow6:Shape = new Shape();
			arrow6.graphics.lineStyle(menuLineThickness,menuLineColor);
			arrow6.graphics.moveTo(sW-(3*paddingX)-buttonSize-((1-(iconPadding*3))*button2Size)-button2Size,(((menuHeight-(2*button2Size))/3)*2)+(button2Size*1.5));
			arrow6.graphics.lineTo(sW-(3*paddingX)-buttonSize-button2Size-((1-(4*iconPadding))*button2Size),(((menuHeight-(2*button2Size))/3)*2)+((1-iconPadding)*button2Size)+button2Size);
			multiUndoBTN.addChild(arrow6);

			//CANCEL//
			cancelBTN.addEventListener(MouseEvent.CLICK,onCancelClick);
			cancelBTN.addEventListener(MouseEvent.MOUSE_DOWN,glowOn);
			cancelBTN.addEventListener(MouseEvent.MOUSE_UP,glowOff);
			cancelBTN.addEventListener(MouseEvent.MOUSE_OUT,glowOff);
			cancelBTN.filters=[buttonShadow];
			stage.addChild(cancelBTN);
			cancel.graphics.lineStyle(menuLineThickness,menuLineColor);
			cancel.graphics.beginFill(cancelColor);
			cancel.graphics.drawRoundRect(sW-paddingX-buttonSize,(menuHeight/2)-(buttonSize/2),buttonSize,buttonSize,buttonRoundedEdge);
			cancel.graphics.endFill();
			cancelBTN.addChild(cancel);
			var cancelIcon1:Shape = new Shape();
			cancelIcon1.graphics.lineStyle(menuLineThickness,menuLineColor);
			cancelIcon1.graphics.moveTo(sW-paddingX-buttonSize+(buttonSize*iconPadding),((menuHeight/2)-(buttonSize/2))+(buttonSize*iconPadding));
			cancelIcon1.graphics.lineTo(sW-paddingX-(buttonSize*iconPadding),((menuHeight/2)-(buttonSize/2))+(buttonSize*(1-iconPadding)));
			var cancelIcon2:Shape = new Shape();
			cancelIcon2.graphics.lineStyle(menuLineThickness,menuLineColor);
			cancelIcon2.graphics.moveTo(sW-paddingX-(buttonSize*iconPadding),((menuHeight/2)-(buttonSize/2))+(buttonSize*iconPadding));
			cancelIcon2.graphics.lineTo(sW-paddingX-buttonSize+(buttonSize*iconPadding),((menuHeight/2)-(buttonSize/2))+(buttonSize*(1-iconPadding)));
			cancelBTN.addChild(cancelIcon1);
			cancelBTN.addChild(cancelIcon2);

		}
		private function onLineClick(e:MouseEvent):void {
			if (startedRect==false) {
				if (startedCircle==false) {
					lineTool.filters=[buttonShadow,glow];
					rectTool.filters=[buttonShadow];
					circleTool.filters=[buttonShadow];
					brushTool.filters=[buttonShadow];
					fillColorPicker.alpha=disabledColorPickerAlpha;
					fillColorPicker.enabled=false;
					lineAlphaSlider.alpha=1;
					lineAlphaSlider.enabled=true;
					lineThicknessSlider.alpha=1;
					lineThicknessSlider.enabled=true;
					fillAlphaSlider.alpha=disabledSlider;
					fillAlphaSlider.enabled=false;
					roundEdgeSlider.alpha=disabledSlider;
					roundEdgeSlider.enabled=false;
					drawType="line";
					changePreview();
				}
			}
		}
		private function onRectClick(e:MouseEvent):void {
			if (startedLine==false) {
				if (startedCircle==false) {
					lineTool.filters=[buttonShadow];
					rectTool.filters=[buttonShadow,glow];
					circleTool.filters=[buttonShadow];
					brushTool.filters=[buttonShadow];
					fillColorPicker.alpha=1;
					fillColorPicker.enabled=true;
					lineAlphaSlider.alpha=1;
					lineAlphaSlider.enabled=true;
					lineThicknessSlider.alpha=1;
					lineThicknessSlider.enabled=true;
					fillAlphaSlider.alpha=1;
					fillAlphaSlider.enabled=true;
					roundEdgeSlider.alpha=1;
					roundEdgeSlider.enabled=true;
					drawType="rect";
					changePreview();
				}
			}
		}
		private function onCircleClick(e:MouseEvent):void {
			if (startedLine==false) {
				if (startedRect==false) {
					lineTool.filters=[buttonShadow];
					rectTool.filters=[buttonShadow];
					circleTool.filters=[buttonShadow,glow];
					brushTool.filters=[buttonShadow];
					fillColorPicker.alpha=1;
					fillColorPicker.enabled=true;
					lineAlphaSlider.alpha=1;
					lineAlphaSlider.enabled=true;
					lineThicknessSlider.alpha=1;
					lineThicknessSlider.enabled=true;
					fillAlphaSlider.alpha=1;
					fillAlphaSlider.enabled=true;
					roundEdgeSlider.alpha=disabledSlider;
					roundEdgeSlider.enabled=false;
					drawType="circle";
					changePreview();
				}
			}
		}
		private function onBrushClick(e:MouseEvent):void {
			if (startedLine==false) {
				if (startedRect==false) {
					if (startedCircle==false) {
						lineTool.filters=[buttonShadow];
						rectTool.filters=[buttonShadow];
						circleTool.filters=[buttonShadow];
						brushTool.filters=[buttonShadow,glow];
						fillColorPicker.alpha=.5;
						fillColorPicker.enabled=false;
						lineAlphaSlider.alpha=1;
						lineAlphaSlider.enabled=true;
						lineThicknessSlider.alpha=1;
						lineThicknessSlider.enabled=true;
						fillAlphaSlider.alpha=disabledSlider;
						fillAlphaSlider.enabled=false;
						roundEdgeSlider.alpha=disabledSlider;
						roundEdgeSlider.enabled=false;
						drawType="brush";
						changePreview();
					}
				}
			}
		}
		private function changeLineColor(e:ColorPickerEvent):void {
			lineColor=uint("0x"+e.target.hexValue);
			if (stage.mouseY>menuHeight) {
				disableDraw=true;
			}
			changePreview();
		}
		private function changeFillColor(e:ColorPickerEvent):void {
			fillColor=uint("0x"+e.target.hexValue);
			if (stage.mouseY>menuHeight) {
				disableDraw=true;
			}
			changePreview();
		}
		private function lineColorOpen(e:Event):void {
			lineColorClosed=false;
		}
		private function lineColorClose(e:Event):void {
			lineColorClosed=true;
		}
		private function fillColorOpen(e:Event):void {
			fillColorClosed=false;
		}
		private function fillColorClose(e:Event):void {
			fillColorClosed=true;
		}
		private function changeLineAlpha(e:SliderEvent):void {
			lineAlpha = (e.currentTarget.value);
			changePreview();
		}
		private function changeLineThickness(e:SliderEvent):void {
			thickness = (e.currentTarget.value);
			changePreview();
		}
		private function changeFillAlpha(e:SliderEvent):void {
			fillAlpha = (e.currentTarget.value);
			changePreview();
		}
		private function changeRoundEdge(e:SliderEvent):void {
			roundEdge = (e.currentTarget.value);
			changePreview();
		}
		private var previewLine:Shape;
		private var previewRect:Shape;
		private var previewCircle:Shape;
		private var previewBrush1:Shape;
		private var previewBrush2:Shape;
		private function changePreview():void {
			remove();
			switch (drawType) {
				case "line" :
					if (thickness>0) {
						previewLine = new Shape();
						previewLine.graphics.lineStyle(thickness,lineColor,lineAlpha);
						if ((sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size)-(thickness/2)<sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size) {
							previewLine.graphics.moveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size+(button0Size*iconPadding),(menuHeight/2));
							previewLine.graphics.lineTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size+(button0Size*(1-iconPadding)),(menuHeight/2));
						} else {
							previewLine.graphics.moveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size+(thickness/2),(menuHeight/2));
							previewLine.graphics.lineTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-(thickness/2),(menuHeight/2));
						}
						if (shadows) {
							previewLine.filters=[buttonShadow];
						}
						stage.addChild(previewLine);
					}
					break;
				case "rect" :
					previewRect = new Shape();
					if (thickness>0) {
						previewRect.graphics.lineStyle(thickness,lineColor,lineAlpha);
					}
					previewRect.graphics.beginFill(fillColor,fillAlpha);
					previewRect.graphics.drawRoundRect(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size+(button0Size*iconPadding),(menuHeight/2)-(button0Size/2)+(button0Size*iconPadding),button0Size*(1-(2*iconPadding)),button0Size*(1-(2*iconPadding)),roundEdge);
					previewRect.graphics.endFill();
					if (shadows) {
						previewRect.filters=[buttonShadow];
					}
					stage.addChild(previewRect);
					break;
				case "circle" :
					previewCircle = new Shape();
					if (thickness>0) {
						previewCircle.graphics.lineStyle(thickness,lineColor,lineAlpha);
					}
					previewCircle.graphics.beginFill(fillColor,fillAlpha);
					if (button0Size>thickness+(button0Size/2)*(iconPadding*2)) {
						previewCircle.graphics.drawCircle(sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size/2),(menuHeight/2),(button0Size/2)*(iconPadding*2));
					} else {
						previewCircle.graphics.drawCircle(sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size/2),(menuHeight/2),1);
					}
					previewCircle.graphics.endFill();
					if (shadows) {
						previewCircle.filters=[buttonShadow];
					}
					stage.addChild(previewCircle);
					break;
				case "brush" :
					if (thickness>0) {
						previewBrush1 = new Shape();
						previewBrush2 = new Shape();
						previewBrush1.graphics.lineStyle(thickness,lineColor,lineAlpha);
						previewBrush2.graphics.lineStyle(thickness,lineColor,lineAlpha);
						if (button0Size*iconPadding>thickness/2) {
							previewBrush1.graphics.moveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size+(button0Size*iconPadding),(menuHeight/2)-(button0Size/2)+(iconPadding*button0Size));
							previewBrush1.graphics.curveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size+(button0Size*iconPadding),menuHeight/2,sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size/2),menuHeight/2);
							previewBrush2.graphics.moveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size/2),menuHeight/2);
							previewBrush2.graphics.curveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size*iconPadding),(menuHeight/2),sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size*iconPadding),(menuHeight/2)-(button0Size/2)+((1-iconPadding)*button0Size));
						} else {
							previewBrush1.graphics.moveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size+(button0Size*iconPadding*1.2),(menuHeight/2)-(button0Size/2)+(iconPadding*1.2*button0Size));
							previewBrush1.graphics.curveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-button0Size+(button0Size*iconPadding*1.2),menuHeight/2,sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size/2),menuHeight/2);
							previewBrush2.graphics.moveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size/2),menuHeight/2);
							previewBrush2.graphics.curveTo(sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size*iconPadding*1.2),(menuHeight/2),sW-(4*paddingX)-buttonSize-(2*button2Size)-(button0Size*iconPadding*1.2),(menuHeight/2)-(button0Size/2)+((1-(iconPadding*1.2))*button0Size));
						}
						stage.addChild(previewBrush1);
						stage.addChild(previewBrush2);
						if (shadows) {
							previewBrush1.filters=[buttonShadow];
							previewBrush2.filters=[buttonShadow];
						}
					}
					break;
			}
		}
		private function remove():void {
			if (previewLine!=null) {
				if (previewLine.parent!=null) {
					stage.removeChild(previewLine);
				}
			}
			if (previewRect!=null) {
				if (previewRect.parent!=null) {
					stage.removeChild(previewRect);
				}
			}
			if (previewCircle!=null) {
				if (previewCircle.parent!=null) {
					stage.removeChild(previewCircle);
				}
			}
			if (previewBrush1!=null) {
				if (previewBrush1.parent!=null) {
					stage.removeChild(previewBrush1);
				}
			}
			if (previewBrush2!=null) {
				if (previewBrush2.parent!=null) {
					stage.removeChild(previewBrush2);
				}
			}
		}
		private function onShadowClick(e:MouseEvent):void {
			if (startedLine==false&&startedRect==false&&startedCircle==false) {
				if (shadows) {
					shadows=false;
				} else {
					shadows=true;
				}
				changePreview();
			}
		}
		private function onClearClick(e:MouseEvent):void {
			erase();
		}
		private function erase():void {
			if (startedLine==false&&startedRect==false&&startedCircle==false) {
				for (var i = 0; i<shapeHolder.length; i++) {
					if (shapeHolder[i].parent==stage) {//idk why I need this but without it, it gives an error
						stage.removeChild(Shape(shapeHolder[i]));
					}
				}
				shapeHolder=[];
			}
		}
		private function onUndoClick(e:MouseEvent):void {
			if (startedLine==false&&startedRect==false&&startedCircle==false) {
				if (shapeHolder[shapeHolder.length-1]!=undefined) {
					if (shapeHolder[shapeHolder.length-1].parent==stage) {//idk why I need this but without it, it gives an error
						stage.removeChild(Shape(shapeHolder[shapeHolder.length-1]));
						shapeHolder.pop();//decreases shapeHolder.length
					}
				}
			}
		}
		private function onMultiUndoClick(e:MouseEvent):void {
			if (startedLine==false&&startedRect==false&&startedCircle==false) {
				for (var i = 0; i<10; i++) {
					if (shapeHolder[shapeHolder.length-1]!=undefined) {
						if (shapeHolder[shapeHolder.length-1].parent==stage) {//idk why I need this but without it, it gives an error
							stage.removeChild(Shape(shapeHolder[shapeHolder.length-1]));
							shapeHolder.pop();//decreases shapeHolder.length
						}
					}
				}
			}
		}
		private function onCancelClick(e:MouseEvent):void {
			if (startedLine==true) {
				startedLine=false;
				removeEventListener(Event.ENTER_FRAME,pretraceLine);
				preline.alpha=0;//bad code but works; removes last preline;
			} else if (startedRect==true) {
				startedRect=false;
				removeEventListener(Event.ENTER_FRAME,pretraceRect);
				prerect.alpha=0;//bad code but works; removes last prerect;
			} else if (startedCircle==true) {
				startedCircle=false;
				removeEventListener(Event.ENTER_FRAME,pretraceCircle);
				precircle.alpha=0;
			}//bad code but works; removes last precircle;
		}
		private function glowOn(e:MouseEvent):void {
			e.currentTarget.filters=[buttonShadow,glow];
		}
		private function glowOff(e:MouseEvent):void {
			e.currentTarget.filters=[buttonShadow];
		}
		private function onClick(e:MouseEvent):void {
			if (disableDraw==false) {//if didn't change color
				if (lineColorClosed==true&&fillColorClosed==true) {//if a color picker is closed
					switch (drawType) {
						case "line" :
							if (startedLine==false) {
								if (stage.mouseY>menuHeight) {//makes sure starts line not in menu
									drawLine();
								}
							} else {//can finish line clicking on menu
								drawLine();
							}
							break;
						case "rect" :
							if (startedRect==false) {
								if (stage.mouseY>menuHeight) {//makes sure starts rect not in menu
									drawRect();
								}
							} else {//can finish rect clicking on menu
								drawRect();
							}
							break;
						case "circle" :
							if (startedCircle==false) {
								if (stage.mouseY>menuHeight) {//makes sure starts circle not in menu
									drawCircle();
								}
							} else {//can finish circle clicking on menu
								drawCircle();
							}
							break;
						case "brush" :
							stage.addEventListener(MouseEvent.MOUSE_DOWN,startStroke);
							stage.addEventListener(MouseEvent.MOUSE_UP,releaseStroke);
							break;
					}
				}
			} else {
				disableDraw=false;
			}
		}
		private function drawLine():void {
			if (startedLine==false) {
				startedLine=true;
				addEventListener(Event.ENTER_FRAME,pretraceLine);
				startX=stage.mouseX;
				if (stage.mouseY-(thickness/2)>menuHeight) {
					startY=stage.mouseY;
				} else {
					startY=menuHeight+(thickness/2);
				}
			} else {
				startedLine=false;
				preline.alpha=0;//bad code but works; removes last preline
				removeEventListener(Event.ENTER_FRAME,pretraceLine);
				var line:Shape = new Shape();
				line.graphics.lineStyle(thickness,lineColor,lineAlpha);
				line.graphics.moveTo(startX,startY);
				if (stage.mouseY-menuHeight-(thickness/2)>0) {//edge of line not touching menu edge
					line.graphics.lineTo(stage.mouseX,stage.mouseY);
				} else {
					line.graphics.lineTo(stage.mouseX,menuHeight+(thickness/2));
				}
				if (shadows) {
					line.filters=[buttonShadow];
				}
				shapeHolder.push(line);
				stage.addChild(line);
			}
		}
		private var preline:Shape;
		private function pretraceLine(e:Event):void {
			if (preline!=null) {
				stage.removeChild(preline);
			}
			preline = new Shape();
			preline.graphics.lineStyle(thickness,lineColor,lineAlpha*preShapeAlpha);
			preline.graphics.moveTo(startX,startY);
			if (stage.mouseY-menuHeight-(thickness/2)>0) {//edge of line not touching menu edge
				preline.graphics.lineTo(stage.mouseX,stage.mouseY);
			} else {
				preline.graphics.lineTo(stage.mouseX,menuHeight+(thickness/2));
			}
			if (shadows) {
				preline.filters=[buttonShadow];
			}
			stage.addChild(preline);
		}
		private function drawRect():void {
			if (startedRect==false) {
				startedRect=true;
				addEventListener(Event.ENTER_FRAME,pretraceRect);
				startX=stage.mouseX;
				if (stage.mouseY-(thickness/2)>menuHeight) {
					startY=stage.mouseY;
				} else {
					startY=menuHeight+(thickness/2);
				}
			} else {
				startedRect=false;
				removeEventListener(Event.ENTER_FRAME,pretraceRect);
				prerect.alpha=0;//bad code but works; removes last prerect
				var rect:Shape = new Shape();
				if (thickness>0) {
					rect.graphics.lineStyle(thickness,lineColor,lineAlpha);
				}
				rect.graphics.beginFill(fillColor,fillAlpha);
				/*
				if (stage.mouseY-(thickness)>menuHeight) {
					startY=stage.mouseY;
				} else {
					startY=menuHeight+(thickness);
				}
				*/
				//Note: All rectangles have the origin in the top-left corner
				if (startX>stage.mouseX) {//Draw in QII,III
					if (startY>stage.mouseY) {//Draw in QII
						if (stage.mouseY-menuHeight-(thickness/2)>0) {//edge of rect not touching menu edge
							rect.graphics.drawRoundRect(stage.mouseX,stage.mouseY,startX-stage.mouseX,startY-stage.mouseY,roundEdge);
						} else {//edge of rect touching menu edge
							rect.graphics.drawRoundRect(stage.mouseX,menuHeight+(thickness/2),startX-stage.mouseX,startY-menuHeight-(thickness/2),roundEdge);
						}
					} else {//Draw in QIII
						rect.graphics.drawRoundRect(stage.mouseX,startY,startX-stage.mouseX,stage.mouseY-startY,roundEdge);
					}
				} else {//Draw in QI,IV
					if (startY>stage.mouseY) {//Draw in QI
						if (stage.mouseY-menuHeight-(thickness/2)>0) {//edge of rect not touching menu edge
							rect.graphics.drawRoundRect(startX,stage.mouseY,stage.mouseX-startX,startY-stage.mouseY,roundEdge);
						} else {//edge of rect touching menu edge
							rect.graphics.drawRoundRect(startX,menuHeight+(thickness/2),stage.mouseX-startX,startY-menuHeight-(thickness/2),roundEdge);
						}
					} else {//Draw in QIV
						rect.graphics.drawRoundRect(startX,startY,stage.mouseX-startX,stage.mouseY-startY,roundEdge);
					}
				}
				rect.graphics.endFill();
				if(startY-thickness<menuHeight){
					rect.y += startY-(menuHeight+thickness);
				}
				if (shadows) {
					rect.filters=[buttonShadow];
				}
				shapeHolder.push(rect);
				stage.addChild(rect);
			}
		}
		private var prerect:Shape;
		private function pretraceRect(e:Event):void {
			if (prerect!=null) {
				stage.removeChild(prerect);
			}
			prerect = new Shape();
			if (thickness>0) {
				prerect.graphics.lineStyle(thickness,lineColor,lineAlpha*preShapeAlpha);
			}
			prerect.graphics.beginFill(fillColor,fillAlpha*preShapeAlpha);
			//Note: All rectangles have the origin in the top-left corner
			if (startX>stage.mouseX) {//Draw in QII,III
				if (startY>stage.mouseY) {//Draw in QII
					if (stage.mouseY-menuHeight-(thickness/2)>0) {//edge of rect not touching menu edge
						prerect.graphics.drawRoundRect(stage.mouseX,stage.mouseY,startX-stage.mouseX,startY-stage.mouseY,roundEdge);
					} else {//edge of rect touching menu edge
						prerect.graphics.drawRoundRect(stage.mouseX,menuHeight+(thickness/2),startX-stage.mouseX,startY-menuHeight-(thickness/2),roundEdge);
					}
				} else {//Draw in QIII
					prerect.graphics.drawRoundRect(stage.mouseX,startY,startX-stage.mouseX,stage.mouseY-startY,roundEdge);
				}
			} else {//Draw in QI,IV
				if (startY>stage.mouseY) {//Draw in QI
					if (stage.mouseY-menuHeight-(thickness/2)>0) {//edge of rect not touching menu edge
						prerect.graphics.drawRoundRect(startX,stage.mouseY,stage.mouseX-startX,startY-stage.mouseY,roundEdge);
					} else {//edge of rect touching menu edge
						prerect.graphics.drawRoundRect(startX,menuHeight+(thickness/2),stage.mouseX-startX,startY-menuHeight-(thickness/2),roundEdge);
					}
				} else {//Draw in QIV
					prerect.graphics.drawRoundRect(startX,startY,stage.mouseX-startX,stage.mouseY-startY,roundEdge);
				}
			}
			prerect.graphics.endFill();
			if(startY-thickness<menuHeight){
				prerect.y += startY-(menuHeight+thickness);
			}
			if (shadows) {
				prerect.filters=[buttonShadow];
			}
			stage.addChild(prerect);
		}
		private function drawCircle() {
			if (startedCircle==false) {//start precircle
				startedCircle=true;
				addEventListener(Event.ENTER_FRAME,pretraceCircle);
				startX=stage.mouseX;
				if (stage.mouseY-(thickness)>menuHeight) {
					startY=stage.mouseY;
				} else {
					startY=menuHeight+(thickness);
				}
			} else {//add circle
				startedCircle=false;
				removeEventListener(Event.ENTER_FRAME,pretraceCircle);
				precircle.alpha=0;//bad code but works; removes last precircle
				var circle:Shape = new Shape();
				if (thickness>0) {
					circle.graphics.lineStyle(thickness,lineColor,lineAlpha);
				}
				circle.graphics.beginFill(fillColor,fillAlpha);
				var dis:Number = Math.sqrt(Math.abs((startX-stage.mouseX)*(startX-stage.mouseX))+Math.abs((startY-stage.mouseY)*(startY-stage.mouseY)));
				if (dis+(thickness/2)<startY-menuHeight) {//circle not touching menu edge
					if (dis<thickness/2){
						circle.graphics.drawCircle(startX,startY,thickness/2);
					} else {
						circle.graphics.drawCircle(startX,startY,dis);
					}
				} else {//circle touching menu edge
					if(startY-menuHeight<thickness){
						startY = menuHeight+thickness;
					}
					circle.graphics.drawCircle(startX,startY,startY-menuHeight-(thickness/2));
				}
				circle.graphics.endFill();
				if (shadows) {
					circle.filters=[buttonShadow];
				}
				shapeHolder.push(circle);
				stage.addChild(circle);
			}
		}
		private var precircle:Shape;
		private function pretraceCircle(e:Event):void {
			if (precircle!=null) {
				stage.removeChild(precircle);
			}
			precircle = new Shape();
			var dis:Number = Math.sqrt(Math.abs((startX-stage.mouseX)*(startX-stage.mouseX))+Math.abs((startY-stage.mouseY)*(startY-stage.mouseY)));
			if (dis<startY-menuHeight-(thickness/2)) {//circle not touching menu edge
				if (thickness>0) {
					precircle.graphics.lineStyle(thickness,lineColor,lineAlpha*preShapeAlpha);
				}
				precircle.graphics.beginFill(fillColor,fillAlpha*preShapeAlpha);
				if (dis<thickness/2){
					precircle.graphics.drawCircle(startX,startY,thickness/2);
				} else {
					precircle.graphics.drawCircle(startX,startY,dis);
				}
			} else {//circle touching menu edge
				if (thickness>0) {
					precircle.graphics.lineStyle(thickness,lineColor,lineAlpha*preShapeAlpha);
				}
				precircle.graphics.beginFill(fillColor,fillAlpha*preShapeAlpha);
				if(startY-menuHeight<thickness){
					startY = menuHeight+thickness;
				}
				precircle.graphics.drawCircle(startX,startY,startY-menuHeight-(thickness/2));
			}
			precircle.graphics.endFill();
			if (shadows) {
				precircle.filters=[buttonShadow];
			}
			stage.addChild(precircle);
		}
		private function startStroke(e:MouseEvent):void {
			addEventListener(Event.ENTER_FRAME,drawStroke);
		}
		private var prevX:Number;
		private var prevY:Number;
		private var startedStroke:Boolean=false;
		//private var stroke:Shape;
		private function drawStroke(e:Event):void {
			if (drawType=="brush") {//stops glitching (having multiple drawing shapes)
				var stroke:Shape = new Shape();
				if (startedStroke==false) {
					if (stage.mouseY>menuHeight) {//can't start stroke in menu
						startedStroke=true;
						stroke = new Shape();
					}
				} else {
					stroke.graphics.lineStyle(thickness,lineColor,lineAlpha);
					if (stage.mouseY-thickness<menuHeight) {
						stroke.graphics.moveTo(stage.mouseX,menuHeight+(thickness/2));
					} else {
						stroke.graphics.moveTo(stage.mouseX,stage.mouseY);
					}
					stroke.graphics.lineTo(prevX,prevY);
					//looks ugly
					if (shadows) {
						stroke.filters=[buttonShadow];
					}
					stage.addChild(stroke);
					shapeHolder.push(stroke);
				}
				prevX=stage.mouseX;
				if (stage.mouseY-(thickness/2)<menuHeight) {
					prevY=menuHeight+(thickness/2);
				} else {
					prevY=stage.mouseY;
				}
			} else {
				removeEventListener(Event.ENTER_FRAME,drawStroke);
			}
		}
		private function releaseStroke(e:MouseEvent):void {
			startedStroke=false;
			removeEventListener(Event.ENTER_FRAME,drawStroke);
			removeEventListener(MouseEvent.MOUSE_UP,releaseStroke);
		}
	}
}