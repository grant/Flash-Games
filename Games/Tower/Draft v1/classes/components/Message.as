/**
 * Messages that appear on a black background on the screen
 **/
package components {
	//foreign classes
	import components.MessageData;
	
	//flash classes	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	public class Message extends MovieClip {
		//constants
		private const REWIND_ACCELERATION:Number = 0.5;
		//variables
		private var rewindSpeed:Number = 1;
		private var messageDataHolder:MovieClip = new MovieClip();
		private var messageData:MessageData;
		private var removedData:Boolean = false;
		private var par:MovieClip;
		public function Message():void {
			stop();
			this.visible = false;
			
			x = 250;
			y = 250;
			
			messageData = new MessageData();
			messageDataHolder.addChild(messageData);
			
			addEventListener(Event.ADDED_TO_STAGE,onAdd,false,0,true);
		}
		private function onAdd(e:Event):void {
			par = MovieClip(parent);
			stage.addEventListener(MouseEvent.CLICK,onClick,false,0,true);
			removeEventListener(Event.ADDED_TO_STAGE,onAdd);
		}
		
		/**
		 * Starts the message
		 **/
		public function run():void {
			//reset everything
			rewindSpeed = 1;
			this.visible = true;
			play();
			addEventListener(Event.ENTER_FRAME,onLoop);
		}
		private function onLoop(e:Event):void {
			if(currentFrame==50) {//trigger data to be shown
				addChild(messageDataHolder);
				removedData = false;
				messageData.showData();
			} else if(currentFrame==60){//able to exit credits
				stage.addEventListener(MouseEvent.CLICK,onClick);
			} else if(currentFrame==totalFrames){//stop
				stop();
			}
		}
		
		/**
		 * Sets the message data
		 **/
		public function setMessage(messageName:String):void {
			messageData.goto(messageName);
		}
		
		/**
		 * Removes the message on a click anywhere on the stage
		 **/
		private function onClick(e:MouseEvent):void {
			remove();
		}
		public function remove():void {
			addEventListener(Event.ENTER_FRAME,exit,false,0,true);
			stage.removeEventListener(MouseEvent.CLICK,onClick);
		}
		private function exit(e:Event):void {
			//stop playing the message
			removeEventListener(Event.ENTER_FRAME,onLoop);
			if(currentFrame-Math.abs(rewindSpeed)>0){//if you can rewind without error
				gotoAndStop(currentFrame-Math.round(rewindSpeed));
				rewindSpeed+=REWIND_ACCELERATION;
				if(currentFrame<50&&!removedData){
					//remove the message data
					removedData=true;
					messageData.removeData();
					//fader
					par.fader.toTransparent();
				}
			} else if(currentFrame>1){//else if you are close to the beginning
				gotoAndStop(1);
			} else {//if you are on frame 1
				removeEventListener(Event.ENTER_FRAME,exit);
				this.visible = false;
			}
		}
	}
}