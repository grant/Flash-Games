package code.soundclasses
{
	/*****************************************
	 * CustomChannel :
	 * Super class containing base controls.
	 * -------------------
	 * See 5_soundmixing.fla
	 ****************************************/
	 
	import flash.display.*;
	import flash.text.TextField;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle; 
	
	public class CustomChannel extends MovieClip
	{
		//*************************
		// Properties
			
		public var looping:Boolean = false;
		public var playing:Boolean = false;
	
		//*************************
		// Constructor:
		
		public function CustomChannel()
		{
			// Set channel name field
			channel_txt.text = name;
			
			// Update screen every frame
			addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		}
		
		//*************************
		// Event Handling:
		
		protected function enterFrameHandler(event:Event):void
		{
			//...
		}
	}
}