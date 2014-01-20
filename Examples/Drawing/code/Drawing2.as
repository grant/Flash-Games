package code
{
	/*****************************************
	 * Drawing2 :
	 * Demonstrates timeline nesting using movie clips.
	 * -------------------
	 * See 2_timelines.fla
	 ****************************************/
	 
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	public class Drawing2 extends MovieClip
	{
		//*************************
		// Properties:
		
		public var startX:Number = 0;
		public var startY:Number = 0;
		public var offset:Number = 15;
		public var target:MovieClip;
		public var dragging:Boolean = false;
		
		//*************************
		// Constructor:
		
		public function Drawing2()
		{
			startX = x;
			startY = y;
			
			// Update screen every frame
			addEventListener(MouseEvent.MOUSE_DOWN,dragPressHandler);
			
			// The stage handles drag release and releaseOutside events
			stage.addEventListener(MouseEvent.MOUSE_UP,dragReleaseHandler);
		}
		
		//*************************
		// Event Handling:
		
		protected function dragPressHandler(event:MouseEvent):void
		{
			// Create a rectangle to constrain the drag
			var rx:Number = startX - offset;
			var ry:Number = startY - offset;
			var rw:Number = (startX + offset) - rx;
			var rh:Number = (startY + offset) - ry;
			var rect:Rectangle = new Rectangle(rx, ry, rw, rh);
			
			// Drag
			dragging = true;
			startDrag(false,rect);
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		protected function dragReleaseHandler(event:MouseEvent):void
		{
			// Stop
			if( dragging )
			{
				stopDrag();
				removeEventListener(Event.ENTER_FRAME,enterFrameHandler);
			}
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			if( target != null ){
				target.x = x;
				target.y = y;
			}
		}
	}
}